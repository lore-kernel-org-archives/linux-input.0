Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793343754;
	b=vhbbpVu0pP9yTUppvcwywSu0scRu2Rg7UZmneP5j6wGd1Zp6EUhw2qRycew/kvdVHcrE
	 PlYvQfG8T3w7Wy4L/ZID3Jl45gLlpI0hC6TTQ8m3KVQtzp44RnurlN2E936pk4EFeRM1d
	 1rw39KjV180W4HjfUMDyCkyRaGUlSCAa3+5ijdAoOvBH7fJC+piwPI4LZ35Vk41Vvjbhk
	 aNyx0NJDObMCg9vPzHpOFMpYAHQOqEXNRGPfofIdQ5GIIVSYMvvglOEdG1vXohmzblDBn
	 aZ3A8r8iCws9/EfVxiD/zVrxVi23oe14wUZnEIA1K3iKoPlwMbIwcJ8E6gcjr7uglGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793343754;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4dpcU2RlVPf4K4eVwU3KUl5PBxFs+UIpVQ7plSzjWkc=;
	b=aquj4Sqlg94EAp4DHsAiWdcEJiGhabY/5wQ1hABK5mB46+uLjldjweneidjUxWFkp3Y2
	 hvIRHlWO8JRQosmgR5eUP1BydhakWAeh58/Sn68DFWQFZ613OcSe6L5qxdISU25NvPn26
	 6AesPY+g0X1T/jYWr6X76L23XNPe0dDRJD3ySFVb2PsNatBhTVUPwP3WjFqQVi9lhmbCQ
	 mmKu0CetEWHPh1vbZYV5nAS3eXmCP/8jivocOGLsuN2ELdKoI5CfGU9D13/mfnuplwDos
	 tCR2CJFzaKDzgsDt2fDOj39roI4CPXiib+QgxTfhktrtGFMNt89yDV+ScsNz36pX+jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=XjG6Deip;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8C8606A329;
	Fri, 30 Oct 2026 07:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=XjG6Deip
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE4F1F000C1;
	Fri, 30 Oct 2026 07:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793343753;
	bh=4dpcU2RlVPf4K4eVwU3KUl5PBxFs+UIpVQ7plSzjWkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XjG6Deipvuk0DbTxTSQoTYjwKLaU6hrXxNeBt3yqOPHIOv7GgfSxYLIt1inEFeDk/
	 B8y62OYM94ZEXGKg6sBeywWUivkZ3N1/GGThHfVoRTW7QhFD0AjJx0ew+j9jrJtL05
	 QDi7G+kVEi8OFJpCjF2DCCxnWYsxIFhIxXLAOF+g=
Date: Fri, 30 Oct 2026 08:02:30 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: jirislaby@kernel.org, dmitry.torokhov@gmail.com,
	mathieu.poirier@linaro.org, linux-serial@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com
Subject: Re: [PATCH v4 1/2] tty: sysrq: don't expose a partially written
 reset_seq
Message-ID: <2026103014-sketch-headed-2fd1@gregkh>
References: <2026103031-hungrily-compile-49c8@gregkh>
 <20261030063053.170432-1-zhanxusheng1024@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030063053.170432-1-zhanxusheng1024@gmail.com>

On Fri, Oct 30, 2026 at 02:30:53PM +0800, Zhan Xusheng wrote:
> Hi Greg,
> 
> On Fri, Oct 30, 2026 at 07:05:10AM +0100, Greg KH wrote:
> > I'm sorry, but I can't really parse this llm-generated text.  What is
> > the bug here.  What is being fixed?  And what is changing?
> 
> Sorry, that was unreadable.
> 
> reset_seq can be changed at runtime, but the new value doesn't work:
> each keyboard keeps counting the old keys too, so pressing the new
> sequence does nothing.  2/2 fixes that.

So the new value never worked?  This feature does not work?

> 1/2 is for a race that 2/2 makes easier to hit.  The new list is filled
> in one key at a time and the keyboards pick up each partial list, so
> pressing the first new key during the write can reboot the machine.

So the issue is that changing the sequence can race with what exactly?

> > And how has no one ever hit this issue in the decades that it has been
> > present?  Is this really something that needs to be fixed?  If so, why?
> 
> The sequence is usually set on the command line or in DT, and that
> works.  Both bugs need a runtime change, and the race also needs a key
> press during the write, which takes microseconds.  I only hit it with
> an added delay.

What race exactly?  That when this is being changed "something happens"?

> 1/2 is far too big for that.  Telling the keyboards about the new value
> only once the whole list is written avoids the race with a small patch,
> and doesn't change what the parameter accepts.  I can send that with
> 2/2 as v5, or drop the series if runtime changes aren't worth fixing.

I still don't understand what the root problem is here, sorry.

thanks,

greg k-h
