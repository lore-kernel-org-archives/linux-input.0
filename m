Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121490;
	b=Uep+EP+u6UkOKNdO3mCL8snGUCTPkDc602wy0V3cNsmWkoZQcdIuf0pXMyAVuC8rD8wJ
	 eCekXv8EppkI4zQ7eXWNenoyBWgeYq8iI2bWjYiun/C37a1JI9KAS5rNW2CiVJ46A3iRd
	 /QROoLgUosDQ0+Mv5h6DD+9agn+CW2SoO4hhY7WGmkRbWMT/sM9NEK6KK/H11amJik/YF
	 aEc5TmkM2vWRIZM1f9MN1oNuz3x+gy73zZrerQ4Tt5gB/67bu5cOE6dq/JiyH92MOF+od
	 CTgfpZ0/j9464MJv/Wj5Y7JkA1PzezGZeElnUJnszvT5AbBGnpoeUn2K5pnTOJsKMDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121490;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=/0wYm0lA67uAPaNe2n9nL/oHpKTlbxqkDIMoWkxXNVI=;
	b=L9NNYVasUU/ZeNduc5Ll6zve0aZstXfQ1qss4mZdPqYhN6m7SKboDO9g2M5kwkxj4hOK
	 5FladR+/xniaKtuoyz22pd6de6lAaQuk75deM5YbuJiRM0pFQp5w7yY0Xz9+1db0BD+Kb
	 ZNFIpKtf0DqvV+j/Wy/dTDbHIE1P7SWtvn4zNz5IqtqgI3k/8HAX17I3xCVh6/vT85oNi
	 Gsm4pgzcUJdkA7SbuBJcSshpCYNr+zoICMFdCYoGCG4QxHA8G54hPewNynyl3DNZoB/s2
	 hZ1DLBOyFsegg1QLWR2KhDslLQofnoaHJTTR0YFSZOFkkAaKftyZNmu1V2JiVAEuphQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lSUc5vHv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56776606A901;
	Thu, 19 Nov 2026 20:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lSUc5vHv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683041F000C4;
	Thu, 19 Nov 2026 20:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795121490;
	bh=/0wYm0lA67uAPaNe2n9nL/oHpKTlbxqkDIMoWkxXNVI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=lSUc5vHvpWGAPnJOUyw+eKkaf2n6kdZj5ADSyrTmEa12Mt16kljh1lAY9Pi5Jx5Rv
	 Cv27EoNTvJL6rynuMx7+mpqWwrVPcCbD+90iQJBJtNWLrqIyPlj926kzj5vsmg0SeE
	 R+40C7tD2kLfDh8NsNkQiwOZDGjamux3kBzhkbQj/61eMWlnKvIB/N0lfjmtKS/9Yd
	 U84L7HnqwUYtVRtmk7yWkTU3yZwg22Eqz+AELT0/PH1+O1c6+TXFiO8TPGxxbwUO9C
	 CIbMqZfAnnZYEheKlldim5HLBmO1PNqMmCybY+4paRuLQ25nebPMbpco7vPuxBwGg/
	 7/oXbzKmQKdCg==
Date: Thu, 19 Nov 2026 21:51:27 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Bartosz Barc <bpbarc@proton.me>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] HID: uclogic: Add XP-Pen Artist 12 (2nd Gen)
 support
In-Reply-To: <20261006003844.10839-1-bpbarc@proton.me>
Message-ID: <r1950831-9oq8-56s3-qsr1-p863s6038563@xreary.bet>
References: <20261006003844.10839-1-bpbarc@proton.me>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 6 Oct 2026, Bartosz Barc wrote:

> From: Bartosz Pawe=C5=82 Barc <bpbarc@proton.me>
> 
> This series adds support for the XP-Pen Artist 12 (2nd Gen) (28bd:094a)
> graphics tablet, which is currently not recognized by hid-uclogic and
> handled by the generic driver.
> 
> It utilises the existing UGEE v2 initialization that is also used
> by other similar tablets. The second patch also adds support for the
> previously missing stylus invert detection. This affects the shared UGEE v2
> pen report template array; while it only reclaims a previously ignored
> padding bit and should not affect devices without this feature,
> I don't have access to other UGEE v2 hardware and additional testing
> would be appreciated.
> 
> The tablet & pen have been verified to be fully working with libinput
> and libwacom, and the relevant .tablet file will be submitted to the
> libwacom project.

Applied to hid.git#for-7.5/uclogic.

-- 
Jiri Kosina
SUSE Labs

