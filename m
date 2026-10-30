Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793360899;
	b=MjyeBgz0OZi7QYg8HuYur57JdVlnSchGncUd4lGT3LzdSKkFxmarBYR9a3mhotypDWpj
	 l6HwKa1xNYKIJMf89DjEd45zBWszxdNcdvXkYeJRO6yBU7h/rQLPdtiJD/hNmIi/90ML9
	 y9CFL5iCN4hnxelTQ+A6YTNwzsyeG7IYgshf808Unr2Zw/8uXEqKUG3TBiwXQy4Vi4exS
	 Sw8BimG/z+bkbki7TDDJFvwGagdfIoYg+u0Czzmf5QbQu6IXoWeUU7v3K0Llgo2yGNQDr
	 s9ikcF/mwQ8hPh8iDgT96huEZ0fzYWDRJWBU79O+tQuCLQnpLKe/sN2T+hGbE3ZDgnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793360899;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=9ys5hbrq7wQ+Mvy1CnKt1UQlSL60GgdTsA7G7RSxRT4=;
	b=x8Cipt4OZk83dl3TD/VeHsWFwyzJ4lNRK+5C/BLuiPwquIoivSaDp0kDg/C8QHbcm9Za
	 Ppn2dK7BFk+I/vWAV+QTVLsXqeA5Gv62DR5eJfg6VDNYTjiu1j+e1QQu9WSfPyFvDezMk
	 hh32Sm3/TVEpProtCVvxcZ3sZCZKAVFj2JDxVl8LW5UnpzNC5QGAac+WW9PBUI04FJ9DQ
	 4/aiMO+jq9jOGWo8djfhAKBnM2w7/jLIHz0mZDrIsOQMVr4EBhElaopEgLeuDGiIKAEU/
	 gVZ8kAXA43r81o3JnOlRJOb3rIPaPKdyAwfuruutBvGaf/zzcH8aKv/YS/hx84yOIrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=KL68tJ3V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A70606A32F;
	Fri, 30 Oct 2026 11:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=KL68tJ3V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D2C1F000C1;
	Fri, 30 Oct 2026 11:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793360899;
	bh=9ys5hbrq7wQ+Mvy1CnKt1UQlSL60GgdTsA7G7RSxRT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KL68tJ3VkFSMZPRVFOWRXzRvSuT8QCMuO9oZfOBvOxF/23/FOE280zcKh0c/6Y26d
	 OiIybLDb6uFRw9dfQocozJ+u/Wren/a3yOvHlLwEsgOnwAQCbkwh2/W6MsaCR7CINB
	 nHO+L982auPkfrv3c8L1xyJqABBqGo41S3uue+rs=
Date: Fri, 30 Oct 2026 12:48:16 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: jirislaby@kernel.org, dmitry.torokhov@gmail.com,
	mathieu.poirier@linaro.org, linux-serial@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com
Subject: Re: [PATCH v4 1/2] tty: sysrq: don't expose a partially written
 reset_seq
Message-ID: <2026103055-ferocity-uselessly-cb34@gregkh>
References: <2026103043-tributary-partake-aefd@gregkh>
 <20261030113356.248358-1-zhanxusheng1024@gmail.com>
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
In-Reply-To: <20261030113356.248358-1-zhanxusheng1024@gmail.com>

On Fri, Oct 30, 2026 at 07:33:56PM +0800, Zhan Xusheng wrote:
> Hi Greg,
> 
> On Fri, Oct 30, 2026 at 09:33:41AM +0100, Greg KH wrote:
> > So this feature has never worked?  Or it is just "one change only"?  So
> > your change is an addition to the feature, not a bugfix?
> 
> It is a fix.  154b7a489a5b ("Input: sysrq - allow specifying alternate
> reset sequence") added reset_seq as a writable parameter, together with
> a version counter so that each keyboard rereads the sequence after a
> write.  The reread just never clears the old keys, so on a keyboard
> that already used the old value, a new one has never worked.  Hardly
> anyone changes it at runtime, which is likely why nobody noticed.
> 
> > So this isn't a "real" issue?  If you are modifying the key sequence,
> > how can you press the key at the same time?  Doing "major" rework for
> > that might just not be worth it.
> 
> Agreed, please drop 1/2.  With only 2/2, that race can hit any
> keyboard, not only ones that never used a sequence.  Do you want 2/2
> resent on its own?

Please resend whatever you feel should actually be applied, with better
changelog text explaining all of this.

thanks,

greg k-h
