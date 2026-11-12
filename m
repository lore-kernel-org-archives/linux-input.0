Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487542;
	b=hOiFcTK4LbNdgblsGe8OEGWjr1FlOA2GHe3MWA1YbdgwN6Mcecy+EDilJG/GdPCW0bLd
	 jiulpkPf91UhlpLtx8L/RLJB+ILlB3x+Tf6nbMnV+H6EZZHV2Fn66AxYLW+hLG3cN3Ech
	 BKduz5SnXH1PnF4G4TKZa+YOL7YKm7rEff3j9/cnG8F7VxGn0p2v4tRCQGWnh+HoWevEU
	 p4MkND+y+f/ltq09I4NBIs6ijziYYV8YebCKNV2GtiIGq/FF6fXXEZgqS1KDDkYgtnwyQ
	 TZ+E5447E4gAyjhcwjUawFfz5JHibJbrGzy4Zst2+EVA2InC6bI0J8bPFUSPh6+sqpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487542;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=VpCk+/HIv7Hx98swHySrIZB8KgIMpjiM+UkgHDX5AIE=;
	b=ykCiIDdEhE5ZOSQcGdoSaRtSWD62QBBGY3vwF2WXLhWx5GEHhgD4VNukhyvRAIw5FOND
	 dKS1v6O0sITo4cwkKxBmDzLL9jIyAZXQDt4qbF1Uzu4+fXo4mcXMUXSZbgfId6Wuy+wGJ
	 s3K5nhu3GkmuFtFgyDMEhCXw2Zp7sMqdelH6qdF/j+y3F6O2N/9nxCqQiB5LrTVZZdJ8n
	 JdKNAmmA5hxV3jo74XWvajZRx0OITwQd5KshANqFKNt9zd8SvQzdsZLUPKmjzYWSnKziM
	 EyUyO/ch1vMDa0Cqt5xCXfZY4PyAB2v+p1Z/71UegKh7KYfreJ/XRcoWCigTqrncJRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=el1Pstvy;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B520606A327
	for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 12:45:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B520606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=el1Pstvy
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-33fb4680717so5286258eec.1
        for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 04:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794487541; x=1795092341; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VpCk+/HIv7Hx98swHySrIZB8KgIMpjiM+UkgHDX5AIE=;
        b=el1PstvymrHEPDC9SiZqcfcg2GMycCDVyoy1Yfz1FY9gLV3vyp3xH2b+xkC7K+ocym
         BRB/jrA697aEgziZUleZXMR93U317+MS938mfxG4gJLwSwR4R1rzg/fKexQPS1AbFFOB
         aUQ5WusHQM5kMcUuqmt9NIyyX8XLRfGilsEtx7tZqAB3PoKkR1J/RYxtmxNx7053dB4L
         mCWj6ybX5ExaMmAnf7ni/24o1RSZGG6mrZ6cCk/2XD97I3u32ToBeYK+wbp+P5kG5rs5
         exby4RpBUN+gGBn5MHgwHrQ0pDm1zq50MZ9VHAFr+pyI//1eI+rcyNz921oZMQKXqCPj
         2Jkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794487541; x=1795092341;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VpCk+/HIv7Hx98swHySrIZB8KgIMpjiM+UkgHDX5AIE=;
        b=rdEZAYExe48NtCxTrYxjUydQg/nV/WkM67xhTfpwnMC/sZ2c9SJJSqd5ceZoc5rZtb
         zCzlRvWu/+sKPHunAi/iMBhg0mrIsUV9W3TUrnkYfuVraruGz43zBF4gx2HTb1UNeUT7
         sk0CKacRqcTNlQEmb8h6akGEt6DBqcs7WB0ce1Sg1E1kaldp+tYwPBU/mg/mk/bgrgia
         w/Xihqf2QenQpX/+N+9bL51RiUier3nElfoz9wIaHEHLUKWx/ahJYoPIj8LayoG6Fj3a
         oT7v9aFlRCrz58R9tHWzRJ2yxEHPWRMUeOAooYyxGYV3bGyTGVxzDojr3doQBQgoOjlI
         qPgA==
X-Forwarded-Encrypted: i=1; AL+hErEuyGqrxwWNRQ3YTQclX441xjRbSWINxZN6zXH0segf1T0m+CN1X+Yk+yd5KNS8SLu3Ly7pYBpGQQYh8g==@vger.kernel.org
X-Gm-Message-State: APuU4Z+vy6U5wLf7lGsdCK2/TOEObbZe3lEwQPi6Z/ao7bHwPjo5YLBT
	rJM2qgda6bvSVGMCMiSeVhdRKQT+PPZj4bfIS9931zbvAiIiHyIgFkRG
X-Gm-Gg: AYBFou3KSwMsJGtC39kOZ2RYOGLsP3SnwXEmF3OzE49ocVO6JN51lpa3zQwbulRMXiK
	fEjUmzio+PaSW0hZV7fAUiiznqSd9HIKHsqj8O6wX5W0uAvjwiyHl1WFSiFCdRwKArc5JW3tRWz
	oIVOFPvm3d7UE3qNXVlx62Q/SZ1MnZ/j7f6dUDCu8EFG4u7UR9cD6WzLeh7epltJPkkGSU1zRhu
	RPEAZ3mwSvZROLrmKjN4YhRGxJZHuS8Kn6QTbjJKQLziuzaW7q3KTCPbWiAS7AVEDXyN6daXSec
	cRSYOxo/2dVwp9wJBeRL3SXxNGvF9CK5TL3NxUgLpRma2545jKqWYVYt92JwKmHCl+uHM83rtIs
	YLg8MjdcZdw4Eb7Pdp2S75gHpbiWCGPoxNUiofaCiLYhG0b5vgvI9qnGjkkf/DAfWVZr0svhWrf
	+hjxa/T/wuOaZOQcaQ7GTzOwnMjoVYRbT1/sp1nJ6Plmd96gLA4l/rL5CROTnUxV7o25+iFfc9o
	4eZj5djUWgfBSrbEc5GslagGOEqZ+rb2kTfxWwfMocVY7OkiTnx1GUwkPu2VTS2jnsYdMyL9lH9
	CG+UigiJlTqWZe3TqVzxa0NlVf8=
X-Received: by 2002:a05:693c:8349:b0:36d:b933:675c with SMTP id 5a478bee46e88-376858969c4mr6125233eec.17.1794487540338;
        Thu, 12 Nov 2026 04:45:40 -0800 (PST)
Received: from localhost ([154.21.93.22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520bf3e18sm55246175eec.16.2026.11.12.04.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 04:45:39 -0800 (PST)
Date: Thu, 12 Nov 2026 20:45:36 +0800
From: Yao Yuan <yaoyuan0329os@gmail.com>
To: Vishnu Sankar <vishnuocv@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Jingle Wu =?utf-8?B?5ZCz6YeR5ZyL?= <jingle.wu@emc.com.tw>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Phoenix Huang =?utf-8?B?6buD5LiW6bWs?= <phoenix@emc.com.tw>, Stanley Chen =?utf-8?B?6Zmz5bu657at?= <stanley.chen@emc.com.tw>, 
	Vishnu Sankar <vsankar@lenovo.com>
Subject: Re: [PATCH 1/1] Input: trackpoint - Add new ELAN trackpoint device
 variant id 7
Message-ID: <avWzauR7nGj90S13@sapienza>
References: <20261102130836.11863-1-yaoyuan0329os@gmail.com>
 <20261102130836.11863-2-yaoyuan0329os@gmail.com>
 <avKBsi-E7IeUgsSY@google.com>
 <TY0PR0101MB4786C8CF42ED66617BD9DA1EDC722@TY0PR0101MB4786.apcprd01.prod.exchangelabs.com>
 <avMcB0q7wF9oP5X8@sapienza>
 <PUZPR01MB477458CD012208A31DE60068DC712@PUZPR01MB4774.apcprd01.prod.exchangelabs.com>
 <avRttU9N0EZeq8nY@sapienza>
 <TY0PR0101MB47865DFC765932B9E6C3E1C0DC702@TY0PR0101MB4786.apcprd01.prod.exchangelabs.com>
 <avVPRySmoH_KKHa6@google.com>
 <CABxCQKt9o--KrucZ-jcG+tb4AGtrBnPY_mypqX64ojWRpoO_yw@mail.gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABxCQKt9o--KrucZ-jcG+tb4AGtrBnPY_mypqX64ojWRpoO_yw@mail.gmail.com>

On Thu, Nov 12, 2026 at 04:14:35PM +0900, Vishnu Sankar wrote:
> Hi Dimitry, Jingle, Yuan,
>
> On Thu, Nov 12, 2026 at 2:33 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > Hi Jingle,
> >
> > On Thu, Nov 12, 2026 at 05:26:46AM +0000, Jingle Wu 吳金國 wrote:
> > > Hi Yao:
> > >
> > > Upon inquiry, it was confirmed that a black TrackPoint stick (0x07)
> > > underneath the red TrackPoint cap corresponds to a vendor that is
> > > compatible with the Windows ELAN driver.
> >
> > Are you at liberty to share the vendor name? Or should we mark it as
> > "Elan" or "Elan-compatible"?
>
> Sorry to jump in; this is Vishnu from Lenovo.
> I have now confirmed with the component owner and supplier that the
> TrackPoint reporting variant ID `0x07` and firmware revision `0xA1`
> are made by JYT/NDT, not ELAN. The physical check also identified the
> corresponding button/stick as white. It uses the same ELAN driver for
> Windows but has different FW.
>
> Therefore, the patch should recognize `0x07` as the JYT/NDT variant
> rather than naming it as an ELAN variant.
>
> Can name it something like  [TP_VARIANT_JYT_NDT]          = "JYT_NDT"
> or something like that.

Ah thank you!

Now with yours and Jingle Wu's info the things become clear now!

I will respin v2 w/ TP_VARIANT_JYT_NDT to 0x7 and "JYT_NTD" if no more object.

> >
> > Thanks.
> >
> > --
> > Dmitry
>
> --
>
> Regards,
>
>       Vishnu Sankar
