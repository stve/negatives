require 'spec_helper'

describe 'Strategy Implementation' do
  context 'Link Shorteners' do
    before(:all) do
      stub_redirect('http://bit.ly/af435', 'http://someimage.com/photo.jpg')
      stub_redirect('http://t.co/af435', 'http://someimage.com/photo.jpg')
      stub_redirect('http://fb.me/af435', 'http://someimage.com/photo.jpg')

      stub_success('http://someimage.com/photo.jpg')
    end

    it 'resolves bit.ly urls' do
      Negatives.extract('http://bit.ly/af435').should eq('http://someimage.com/photo.jpg')
    end

    it 'resolves t.co urls' do
      Negatives.extract('http://t.co/af435').should eq('http://someimage.com/photo.jpg')
    end

    it 'resolves fb.me url' do
      Negatives.extract('http://fb.me/af435').should eq('http://someimage.com/photo.jpg')
    end
  end

  context 'Image Services' do
    before(:all) do
      stub_success('http://yfrog.com/23aaf456')
      stub_success('http://twitpic.com/23aaf456')
      stub_success('http://twitgoo.com/23aaf456')
      stub_success('http://img.ly/23aaf456')
      stub_success('http://plixi.com/23aaf456')
      stub_success('http://moby.to/23aaf456')
      stub_success('http://imgur.com/gallery/ZR12c')
    end

    it 'resolves yfrog urls' do
      Negatives.extract('http://yfrog.com/23aaf456').should eq('http://yfrog.com/23aaf456:medium')
    end

    it 'resolves twitpic urls' do
      Negatives.extract('http://twitpic.com/23aaf456').should eq('http://twitpic.com/show/full/23aaf456')
    end

    it 'resolves twitgoo urls' do
      Negatives.extract('http://twitgoo.com/23aaf456').should eq('http://twitgoo.com/show/img/23aaf456')
    end

    it 'resolves img.ly urls' do
      Negatives.extract('http://img.ly/23aaf456').should eq('http://img.ly/show/full/23aaf456')
    end

    it 'resolves plixi.com urls' do
      Negatives.extract('http://plixi.com/23aaf456').should eq('http://api.plixi.com/api/tpapi.svc/imagefromurl?size=large&url=http://plixi.com/23aaf456')
    end

    it 'resolves moby.to urls' do
      Negatives.extract('http://moby.to/23aaf456').should eq('http://moby.to/23aaf456:full')
    end

    it 'resolves imgur.com urls' do
      Negatives.extract('http://imgur.com/gallery/ZR12c').should eq('http://i.imgur.com/ZR12c.jpg')
    end
  end

  context 'DOM Interpreters' do
    before(:all) do
      stub_success('http://instagr.am/p/OoFVV/', fixture('instagram.html'))
      stub_success('http://posterous.com/foo', fixture('posterous.html'))
    end

    it 'resolves instagram urls' do
      Negatives.extract('http://instagr.am/p/OoFVV/').should eq("http://distillery.s3.amazonaws.com/media/2011/09/30/aab58b51eb2c452ea16cb2856ae64825_7.jpg")
    end

    it 'resoves posterous urls' do
      Negatives.extract('http://posterous.com/foo').should eq('http://posterous.com/getfile/files.posterous.com/ankuriview/mAbriEHlFFzqhrjnnmquJmkDjaeIJvrbCezCnmfuteIEqtAuEcJxGvvAcwGm/p104.jpg.scaled500.jpg')
    end
  end
end