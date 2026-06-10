Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D717287263;
	Wed, 10 Jun 2026 18:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781116012; cv=pass; b=iQ07qXoLVNbao5/Yc1uBVT05ddJvd4cSL33lq7P5aGJtOroHzdwwsezn9ArQbaidvEcP9BYRZvgeV0P3k2TrXQXudrwtJn9+HWhMgYDInJ7t+noUybb+Cbx5+IVIszbWdhhH1mgk5jC+k0wQWrPtO5YqRNIvSq3MHtBQ94WUSCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781116012; c=relaxed/simple;
	bh=KktD0yEnCqbOJVQAr52xnBbxBTMHqJhPHeoNJP4Ukt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brvrrqEemNJfb9GwrrWIws9VeR61nLaxsPE5yYUbK9k2S5S3l9CUeAxHVqmZm1TGYcerogOupu3YRFelUpehQZBMRgqXBcWchsiSpltWRMTGrI2r3VWe2AVCmiokFFj2EzcIBRNCAF5/hbdEq5vw9nQTGR1KFHR/WjnCLPAOWeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=mN7ObDL9; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="mN7ObDL9"
Received: from darkstar.musicnaut.iki.fi (85-76-129-141-nat.elisa-mobile.fi [85.76.129.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aaro.koskinen)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gbDkn0jFSzyQX;
	Wed, 10 Jun 2026 21:26:41 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1781116001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tNR9w4EUOgQ7at2+epOtBFl8QZO0/oNXb9ljzJtrJVk=;
	b=mN7ObDL9qusxf2szCAnAFaDjt9jL76yVyXxz/fEge7ZG4TJV4pe5uJzr9Aua4RTK7QAKMo
	7TVFfmPMksaEp4NbJc4ZV8eLlcdP/9sRipSTvEiBpjMa2FoqUDa2/4Nxf8FtQ5gLDo24aA
	mJBi3oGEQmWR8zKmYXru50eB60xW/bU=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1781116001;
	b=cop0cgtYnADl/XMAGyfbvoLcbmxAEBiwVAlPXxAdIofeXidXFwjOGkGxw76Oe2iTrJ0w3U
	GqivHLkWlXiZEmMRZWZHCoE7q9mDozgipqXo3xAHfpqGAL1mUqJqWlpoF4uYfFHyuUh9h6
	bHeXm3yW5bdHlxR6WpttVfKvAjhSNQQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1781116001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tNR9w4EUOgQ7at2+epOtBFl8QZO0/oNXb9ljzJtrJVk=;
	b=v60ML0FRGQnS7611VQsF9M2phwnbb64Fb3VPhNgT9/QydmTjbLQTMdg0dOEVZo5kwGovYS
	lP8gztI4kiAV0eOszww9ScvpxdXwj4WLQJRHOv6BBZF64uwNgTsS7MP/d7++992sYBoRWx
	nfFOM3GjpJTVpTdaIMhusoVU6H87+yQ=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
Date: Wed, 10 Jun 2026 21:26:37 +0300
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kris Bahnsen <kris@embeddedts.com>, linux-input@vger.kernel.org,
	Mark Featherston <mark@embeddedts.com>,
	Marek Vasut <marex@nabladev.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: ads7846 - consolidate coordinate filtering logic
Message-ID: <aimsXWeg3wouoiB9@darkstar.musicnaut.iki.fi>
References: <afl3WtbabMFNjE24@google.com>
 <cf9e30d8-f51b-4a19-ae7d-914e6bccb265@embeddedTS.com>
 <afzo03UP-shPfNMe@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afzo03UP-shPfNMe@google.com>

Hi,

On Thu, May 07, 2026 at 12:35:04PM -0700, Dmitry Torokhov wrote:
> I think if you pull 'next' branch of my tree, then the following patches
> seem to apply cleanly on 7.0:
> 
> c68bc840f06c ("Input: ads7846 - restore half-duplex support")
> 011bdf9f3a9d ("Input: ads7846 - consolidate coordinate filtering logic")
> 
> I hope they also build ;)
> 
> c68bc840f06c should appear in linux-next soon too.

Did you forgot to push this, or was it dropped? Because I fail to see
it any any tree...

A.
