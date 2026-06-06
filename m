Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594243AEF35
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 21:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780779706; cv=none; b=AbyKk7lLqYNnMO5dCC/JymLgzEelR+XA/1I3QMzINtPriiLqb7ec6j45cEJz7rdj9VEVSAVehCoHCO8XWt3/KoC1PtnyGdf4JTY63KGgJnXj8BFC/VSpzF2doYMoFacqSLFL2GmcH55eJ79vmqPO4r55I1TExfJAjMOQlvGlkzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780779706; c=relaxed/simple;
	bh=sFHoZUB84WQUJMVXpebDMn9mFFy9QnYO3FFabZWh+zU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmspXuCrIzWKYqkIbEhFbBCd2QHL5Oaqf3p3iacAIOfqKeD9SNBBtSiU084lC98AiQYYC0/Syuucu/HL0jdEHLmh/nY7Db3apVxfpJixDoqy9mekzOwupEDcKbXlfxF5YfDY4qv6nsjLt2hRVa+2GES1PKjh1pbuYgLA7HhzDpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ij1FATMX; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ij1FATMX"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-307631dbfedso6872083eec.0
        for <linux-input@vger.kernel.org>; Sat, 06 Jun 2026 14:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780779704; x=1781384504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/tIW5V2iGf0T/iY4Wo1QvntK0SSmiv71FmChmR6T7j0=;
        b=ij1FATMXnACwwedm5+OnV6V3R42KqWI6Qm/iKvMccwxQB1D0d0S4bZ78bgobPgfGzE
         MlIj7SMQaiLU5liabK41hv9lEJQQUwJsiT8nTCma4kLsTu0hEUsvU7K8dhyETsL5U7hr
         Xk95TD2F2DhnHHjRsvsUhI2099Oi03AYBRmlu0L4YHZ42j8NvYiML/lWsgoV6tBROEcb
         wjy2qpFWfzFAztThbqutVhVoxNejSwJNcF3pYtENvDlvP1oONT2iIsY/ytTKY30rHafA
         PaRc0p3vpEMGxHZTDg0eg6WM5P0Ud7ovlFr+Gg+jWN+EENLLeHtSPfI2vy6tiT+v21Aj
         WViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780779704; x=1781384504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/tIW5V2iGf0T/iY4Wo1QvntK0SSmiv71FmChmR6T7j0=;
        b=QMP4AkVQ8NZ2GHTT14VKXVTJbqRtFJwMW1m25rnq3uNdEdkr56D+yfYCRhGoAKz/EQ
         VcJ/kAxPYGMxvAuF117ZMO105CMDTVhvzMH39LLbs9AirY1cBkOhSPr2EygYGcW494Lb
         znqDPGZYR6FsS6Jex8E99uv2/vBb02UUqAuL6RqF8szDNHS2cqqF5hifKoCPSv8qwE6R
         5R3BS4u09fKqqXdxVG8f6OlN3h1Bd16xMUxD7xVbNl6TSGU+ear62SxVTJ5/Tm7ifKXj
         1fRMcvvq7MuWrPclGDkB4jzRotDhNMBthrPkYlHAvtFR/C290q74Yz/AscK/QMOqx5JH
         u5Uw==
X-Forwarded-Encrypted: i=1; AFNElJ+iRI9JDXix5JKugMpIzBsfuw6HjUU5xEyIhI31Gri34UYt1OL/pSFy9tmcwPxXHsB1LyPXzl1Xe8GflA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzorr1RbVBIEgsvh4nlX4pg4uDZ6GfYWSAEGVNTqehTA94ahpum
	vWy3nntiGZ70YfZuA6E3irdVtYE9IVcp4qF1T5UAvvupLkLXZjcQ6Bq+
X-Gm-Gg: Acq92OFFowJKe9Es79eFZWmMht2DMB6Qbar2oMHjnWuQ0CfjgtURTSB75HXjrczGDb3
	sv2xIZkcn98hTpYQr7yan5peGlPat+Jv+Xm2offeRmG6kQuT7L1AgjCQxoNQ5ywvmsCpYp07r5w
	8w7QxenzlE8qi1GlFrCdTqA7QG1Y2KPNacO65R4xaayWXDouR+Sd+mgbLUn6WwMWOC/ZHBLA96x
	6weCmFG0qysWPNlLw9Ks57je9i9nBL+Sssz86fQ6nqVWqnaour6dBWsoD474xHtosilQ/cDv/MR
	Qnt/jR2GVWp9KL9k7GAqPShjgtqDr3q/yl9hALlD6UGT0RgWPjVQL+n7XsXk/w4/pVuMrWp8muJ
	lm5FkTD/H0+N9HJu/82seRq5klVzXuNq30qRz8t5WpdRlezWuM2eLIiZ1CDSZ1B+D0jkgfv55s3
	X5L1KriaBnlrJ/GEwCMJRvUIb64xrT8qj3PvDLMhH3UHvge6DpcpuN9ipzhEHQfjNj3Y1jyqhtb
	zk=
X-Received: by 2002:a05:7300:3721:b0:304:d4c0:82ea with SMTP id 5a478bee46e88-3077b47ce9dmr6055191eec.21.1780779704426;
        Sat, 06 Jun 2026 14:01:44 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:bb2f:1c0b:386d:8909])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df48671sm12017378eec.24.2026.06.06.14.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 14:01:43 -0700 (PDT)
Date: Sat, 6 Jun 2026 14:01:40 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Cryolitia PukNgae <cryolitia.pukngae@linux.dev>
Cc: Hans de Goede <hansg@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhanjun@uniontech.com, niecheng1@uniontech.com, 
	Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>, kernel@uniontech.com, 
	Hongfei Ren <lcrhf@outlook.com>, stable@kernel.org
Subject: Re: [PATCH] Input: atkbd - skip deactivate for HONOR BCC-N's
 internal keyboard
Message-ID: <aiSKsQCKmRh_FuzS@google.com>
References: <20260605-honor-v1-1-78e05e491193@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605-honor-v1-1-78e05e491193@linux.dev>

On Fri, Jun 05, 2026 at 03:27:21PM +0800, Cryolitia PukNgae wrote:
> After commit 9cf6e24c9fbf17e52de9fff07f12be7565ea6d61 ("Input: atkbd -
> do not skip atkbd_deactivate() when skipping ATKBD_CMD_GETID"), HONOR
> BCC-N, aka HONOR MagicBook 14 2026's internal keyboard stops
> working. Adding the atkbd_deactivate_fixup quirk fixes it.
> 
> DMI: HONOR BCC-N/BCC-N-PCB, BIOS 1.04 04/07/2026
> 
> Fixes: 9cf6e24c9fbf17e52de9fff07f12be7565ea6d61 ("Input: atkbd - do not skip atkbd_deactivate() when skipping ATKBD_CMD_GETID")
> Reported-by: Hongfei Ren <lcrhf@outlook.com>
> Link: https://github.com/colorcube/Linux-on-Honor-Magicbook-14-Pro/issues/1#issuecomment-4562679891
> Tested-by: Hongfei Ren <lcrhf@outlook.com>
> Cc: stable@kernel.org
> Signed-off-by: Cryolitia PukNgae <cryolitia.pukngae@linux.dev>

Applied, thank you.

-- 
Dmitry
