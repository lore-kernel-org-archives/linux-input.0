Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.185.170.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793039276;
	b=y1QAaJbcbURfK+9uWsB10d/VqAIG9rVx6QDQ3MP2cE0jmcYMqgQyvZhMnOOWOHJpo92l
	 XtDORSdmoGKHRruO+yaEKs07m6Nl+j3YmFKtlpoBJPeflTJCTlQKUGcuN524nz7SV18JA
	 v8OcgZMBi5MXZ/Sqsnlfayd6Iv47kQFLngdEN1H91ZiO4qqnaD15PzbuLZHCiPSNWHNdb
	 fbCXPZ39aqVDlGzZVyb0gYl8UAsi8FecmT1N0Z+dwvd+gmdNWOR2txTUNH0J9fXJ4iIF6
	 SLLYaiaQoS7epHf+FW7ZLPvutn8cf+5R1qx36W2Xz3wuaqHWx1U8rOneTdx57xbnoDQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039276;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=BBul2vfrhQZO13559zXI+nU0OldkKMALm3TltgUUqyo=;
	b=iup0Y3wwvcOLY7Z2NQNzD6H53i5d+YmKXzCMDuY6tBjGE+8J0sR76UNjRfLL7JoWr/C4
	 u0JGTCq9rPPOh9Rh+oOWPWr0aEk4/VFBuEreZreY4e5btyY92HYzVBxip/XgyemjgqdQm
	 dkgj/dT3MBLm9xbPgN4Wf90CLNmgnjyqEKEiSTS0h3vw8isgIAH84m5dbd6RZZRB4Qoek
	 TRvm37DtPSq7TRByMRBOk5gtnZj71Hr1hokRg9erh9u1w/CV1PcnxJQrHnwlI3BlVIhvH
	 Q1a2nzjkrOZrOCjyyL36vBDYJDrl4Y489iubCqX18FztGH9IiQIXg6NvshUa4W4PLZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iki.fi;
	spf=pass smtp.mailfrom=iki.fi;
	dkim=pass header.d=iki.fi header.i=@iki.fi header.a=rsa-sha256 header.s=lahtoruutu header.b=hNoKH0LG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.185.170.37
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A79606A31F;
	Mon, 26 Oct 2026 18:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52A79606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iki.fi header.i=@iki.fi header.a=rsa-sha256 header.s=lahtoruutu header.b=hNoKH0LG
Received: from hillosipuli.retiisi.eu (n18ws8cotq5gnfn8-1.v6.elisa-laajakaista.fi [IPv6:2001:99a:0:19f:4ce7:0:938c:d2f4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sailus)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4jD2DM5nSBz49Q3t;
	Mon, 26 Oct 2026 20:27:47 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1793039268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BBul2vfrhQZO13559zXI+nU0OldkKMALm3TltgUUqyo=;
	b=hNoKH0LGisklu5ADzk3bdmXT8nh/v0M1z51mHAq74AE8f2UQFf9wPfAfYo5OE2VWGcbOAY
	XtiS3VGXm3dhkAErEdW6ZEb9IW56DsaaK7N6Di1+p4H+dH5tk7+a0Jck6hNTsWkLAcnO+4
	cbxK8tvtSR7R1ASct02uf2X+x3N6IZG4T6Tkiq9cRMxjT6aUhIJQirAhebg4+jZfU2GyXk
	mDxy4szFf5mwUVB1voCcQyKsm84cTuqSBPSSIQB+ncNODocxcWSrBFGVPsFIJbqNGpv2Jh
	eyUi+C0b3aFYGsMJqTVR6D5X3V5ye9b3MaN7oZzykkjn+FwfCCdBXh2esK7VvQ==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1793039268;
	b=C553BT3aWaWWkSVGH0H/rUH6T1Qpw1JeaF7ubmjG9j0focuB7yuZbWYfvQpYu1KJhMkAPo
	UT1dwfcNzxfjee5znLO6oGfCObzRcqMfcFR1H9JklQMbp0y/HWSDGtUvAZhBUSC5lAGWii
	r/lX+53+xzhEclc3fKTWgag96SnyVmCNavaMYjax7jjIQRA4mPw6vaYRT8mCIljKSqDH0j
	eexz6vl6FZNPjJq6VZNae1V+d/5SpMEc59pZrLtAomdB2h6LQNaM+d1OUUOCHx9elIr/x4
	Ycx+VW9LeRWgU2jrNDBYLMrrY90AShuCuozNmjHRYeJ2hqS5ncNnc12l4bSN6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1793039268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BBul2vfrhQZO13559zXI+nU0OldkKMALm3TltgUUqyo=;
	b=t12HGNMVoK2iH6571tnm7GOhfH9w0LdKPp9sk/eYbzDigGfWE7yj+2+u8bN1VVLeTU7M6U
	XoPEx0Gn9ZHFAjRS2m5h0pJuOkdoWMfgUgWq7aubXjRv+XfPszw3i1AxSGuf0kaNiy0RTN
	MLCxGKT6gGncKVOyEy+0onJRQDEYFYlpUgEcromC+PX/uIx5oJa/iLPEY0y1HDd01+qpB2
	aKGdKX3vl//HXxBFyKr9fZ7JjbkWpWhbw1sladzQaJ3HFdnNhBJEAMudYpRjMMQ/GcQDkq
	epZjTYYg5A46FLoc/Ke9vf/FrfGqW0WQ83lIc0Jy6GtUtlwRTgTwGZkMuMl99g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
Received: from valkosipuli.retiisi.eu (valkosipuli.local [192.168.4.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 2C777634C4E;
	Mon, 26 Oct 2026 20:27:46 +0200 (EET)
Date: Mon, 26 Oct 2026 20:27:46 +0200
From: Sakari Ailus <sakari.ailus@iki.fi>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Denis Benato <denis.benato@linux.dev>,
	LKML <linux-kernel@vger.kernel.org>,
	platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>, "Luke D . Jones" <luke@ljones.dev>,
	Mateusz Schwartz <matthew.schwartz@linux.dev>,
	Denis Benato <benato.denis96@gmail.com>,
	Jonathan LoBue <jlobue10@gmail.com>,
	Khamunetri Clark <khamunetriclark@gmail.com>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Joshua Leivenzon <hacker1024@users.sourceforge.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Rebecca Mara =?iso-8859-1?Q?M=FCller?= <rebecca.mara@posteo.de>,
	Ivan Levchenko <me@livan.pro>,
	Corentin Chary <corentin.chary@gmail.com>,
	Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH v11 08/18] HID: asus: add support to force feedback
Message-ID: <at-bouHWm0fRkA-c@valkosipuli.retiisi.eu>
References: <20261025235232.129945-1-denis.benato@linux.dev>
 <20261025235232.129945-9-denis.benato@linux.dev>
 <at9JNgMf8EZdCHEh@valkosipuli.retiisi.eu>
 <1c017f49-bc69-fc68-20f8-0c66a2c85719@linux.intel.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c017f49-bc69-fc68-20f8-0c66a2c85719@linux.intel.com>

Hi Ilpo,

On Mon, Oct 26, 2026 at 08:21:54PM +0200, Ilpo Järvinen wrote:
> > > +	u8 *dmabuf __free(kfree) = kmemdup(buf, len, GFP_KERNEL);
> > 
> > It's not very nice to assign variables and then check for errors. I'd thus
> > separate the declaration and the assignment.
> 
> I actually thought the same thing first.
> 
> But then stopped and realized, it's mid-function declaration of a cleanup 
> variable exactly following the guidelines (the long comment in cleanup.h).
> 
> So this function doesn't really have variable declaration block at all, 
> making the mid-function variable declaration look like one. I understand 
> it looks confusing when encountering this for the first time, it was for 
> me as well.

Indeed. I missed __free() there -- one shouldn't review patches too early
in the morning!

-- 
Regards,

Sakari Ailus
