Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795394637;
	b=v3US4KXIzEA6vPj+rh/esCT78XA+aOhHfY2Zvvmd9WGdVIfaHsfUXvCAF8mT6yj8ZPd2
	 0k6EMbSrlWAnA6mkk4hosTSMrWiT7oDEPvWUEgP4hC2X8j5mmcl9/yvNnFy+6LulIJkmL
	 y78kQ2TG1IV8vM+erq0LxadTyXF63eT+/KcxthDhkVElMkn4L4Q+HZMFIJ09CNlBx3IUq
	 JTFer21Wm2Lc3N00wX8tOTWk/YIt0fKSZIO2OtRDKvo6yk5xY0kh53xD9h6pO+P4rQ8iP
	 t5fI/suBitHywoqM+FN7vK+LdL5pDkrXoyieBcECm5d83/WeHySDs4BZpQPcxpilemg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795394637;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=hERkEl359vLOsdajk6MWJ+B5BvnrFdUZj62Ly/eBB5w=;
	b=3tX0lpgkyDo56R1xnTtGu860ig5NgHE6UAZriEaG38CNV3q2/byVbC0gCJuxhER/tBFN
	 xv4j+rPENCNWB4C6PZ47V1Y7o4hLP1SsUfs21NXzBzvx5La/xZOmWpEETgrT2xwjOQ3uK
	 /p7wkD1FTjytYxWoz3Av2Z0FMCq0JVbglwa6vpWm6sEbzfWwFYnCKpOol1wgSh9P4/nMC
	 OZOiJSIRQxeyFJBqV7qPJIFViJ5N9cbPDuoSI6m4SuEO4izTJLm5q3KKqSI1p/R/ZTbld
	 8kEgBGbB5U8j82yd1xqAsUxxSIGSYWDo7gAD8RESqa6kdh2OeccURGak6RuaeT/w2Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yDiEPN1p;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F3C606A33B
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 00:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20F3C606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yDiEPN1p
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-385d8a00598so3702046eec.1
        for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 16:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795394636; x=1795999436; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hERkEl359vLOsdajk6MWJ+B5BvnrFdUZj62Ly/eBB5w=;
        b=yDiEPN1pQUlhdE37Y1+BFEbw855fPdSHoC9n6iTwjrU2bsGXPgBB63jpe912HqB7bL
         +xy3zT0hS+uPXs5AvWwlmjQ8qPDHqlrvb/yOJnsfpCvXGuDb/gdvRhJjJqpTAY+Eepd3
         L9Bx7s0RkOgxLRCSXzDaU27qLlWTxK14pNszTBa0NkqbAV+uPEQh3SwBJdouGXUCQsGW
         RaOnQC8o+MndCNyuimFkryhjMrN1vZhUL1Bnb0qO8uDPYRBn/Ua1aoDZCFJiuH5zlCSl
         NhiH5JsdiR4RSjrouMFTZU9gfgnC8IikwTe/lJi79DU3O0/R1SfFAiz4o3HYd1GKSBmO
         TXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795394636; x=1795999436;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hERkEl359vLOsdajk6MWJ+B5BvnrFdUZj62Ly/eBB5w=;
        b=vRSLZl+vWrMlTVOkDjr7DwGbVZU7q5eF6hmOxXpABhrjo1cUMwpomI7+kbwh+LxvS0
         jVTCvqzNP1gEx0g6I9PuFIV3CyQ9JdP29vCMYwpFTvwP3QbOPaj/KHu0eWew2tLzcXnr
         DqSNsX8JgQFCVnm6Bf9zrk7NIaG8AoOLBkJvhPIirkeLQQDLw79q+GSQb9lbcMnv2xcT
         jMfWxv6GC2P2eLf9PZXia4jtkPzcAMd+il1aCYsppDiPOFJYn7ronBfEtlCK9ChMIZ0W
         q6cCItnOhTxXCVR9IgV8E/Ryy5bVuAXrKeUJpJsEHxXd8aU1V7gJD09wMeBbK2wMdsER
         yZDg==
X-Forwarded-Encrypted: i=1; AL+hErH7RrIQTHmPY1g+/WBlMNzFYJ1CUS9flmT7mwtpj4TBXMEkVaJYeGCxmzpB9jSIuPykqg31LzkadEAjHA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8bKBjJWGhFSWW4QdK8QOXZHfWzMPuGeJGTZHBgWVTh6ct2TrWR
	NYemVrIkQWc73LtoBkGuKxtOVg0miC6XhbGm5rmEba2D8l/7/VEHvDjS
X-Gm-Gg: AZFdTZclKPSVlKl0ENYjXc19XBDXayO71tUQgWiU+9M7m80+tBhbi+gHj7+zBfd8XIp
	VOIkILdiOsQUcIqorFtyS9jyy44kuznANSqxnCOwGRQtc4PXzHw+hRsnWRU74XMBXV0YCrIKNfp
	VVOZUChcI2HsXCFVi/x9siXo/P4N4S7mJuNcnm+d/dmzbg9TkvcYLzdKraTmhkBHSOsA7iiEf5y
	ZpaC9/Xc4kQZdsAvUpmeHs81YQui/XSAWAvMv1aKox7DSztAzEWUJL999/UnwuAMnFVocQ1IKlZ
	1DcKBwEKRYXOcc5q18jviPLYjUNfOKSB82YqpLMguUA4BsTj6XNkKpxpEV/2MsP948P19bYrj7X
	sRcbwT+fheDRHUVJqZd2iOlYNYeol8ksXVwNRF66W0P6ydpvXEYpTt+Jun0NtignZQGVc/M2jU7
	vaxn5Pvmpb00yDdS2Epj1VOMt6ugvA9v8qxWB7Yc6bXR0ZI0Er8IpdXiWg1eBkHELkNj3UzPvFY
	F5fqtwiCLIzjIXojlYIQ1hBYTzyBlkTs0tRIGf3UeixCHBzPcYVefowmZOmViEN5zAdKreZ+cfF
	UJfsP04pmyFg4TCc8B55zraqjTxVsh95OASYMyFja6D8X5fonxgoYfJHcTHnPge88ai9kw==
X-Received: by 2002:a05:7301:6482:b0:386:ab5a:d3d6 with SMTP id 5a478bee46e88-386ab5ad5d7mr2908764eec.12.1795394636119;
        Sun, 22 Nov 2026 16:43:56 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:f002:4621:aeeb:e0e7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386b4db79a5sm1141355eec.9.2026.11.22.16.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 16:43:55 -0800 (PST)
Date: Sun, 22 Nov 2026 16:43:54 -0800
Message-ID: <38aa3aea5c8c2607f40938b9968baf32@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	Andrew Duggan <aduggan@synaptics.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] HID: rmi: Fix report handling, device lifecycle, and clean up code
In-Reply-To: <s9prps69-s294-r1q1-319o-1orrpnr9r9p2@xreary.bet>
References: <20261113-hid-rmi-v1-0-afc43d97d766@gmail.com> <s9prps69-s294-r1q1-319o-1orrpnr9r9p2@xreary.bet>
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
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Jiri,

On Thu, Nov 19, 2026 at 09:57:17PM +0100, Jiri Kosina wrote:
> On Fri, 13 Nov 2026, Dmitry Torokhov wrote:
>
> > Jiri, Benjamin, could this series go through the input tree once
> > reviewed, as I have follow-up RMI4 core changes that depend on it? Also,
> > would it make sense to move hid-rmi to drivers/input/rmi4/ alongside the
> > rest of the RMI4 transport drivers?
>
> Please, take it. The HID queue is currently so tremendously huge, that 
> anything that you remove from it would be greatly appreciated :)
>
> 	Acked-by: Jiri Kosina <jkosina@suse.com>

Thank you! I have queued the series for 7.5 with a small tweak to patch
4/12 to use disable_work_sync() and enable_work() in rmi_suspend() and
rmi_post_resume() instead of a separate RMI_SUSPENDED flag, avoiding a
race with rmi_event() re-queuing reset_work during suspend.

Thanks.

-- 
Dmitry
