Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AFC30BF4F
	for <Linux-input@vger.kernel.org>; Thu, 23 Apr 2026 18:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776967343; cv=none; b=lVjdtseE1PbeRJSqiWKN9kbLHFnkSenfCo9PuHyNuPJ3wwZ7fkXlJrJ4o+IFQ4a3dLosISl7ArmjEQgk69wabEvvLdusc7vIpPtiSC5IvqFTNARHKNDhG4Q9QoUGmlOKgQVkF7Ff3GjMrnpKQw9LnJsSZsUtyvvGciwpOS0v+4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776967343; c=relaxed/simple;
	bh=r0R20wCh8nE2MmXjcLRKuJIe3i9K+zM1L+E1C7rSXfw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EcrX25o0ukmu7rM7tY+CChFOjHmFV7+faRA/awiRhpuLh7RqdWI3KbwUTq2z0PW4stVJO8HAryezKCc/Vcf2Buxbn9biB8zoNpQ2smw7okbvLPCgRAEuyqW/varJuUTu9ryquL8+UiRXUT2ph5bO7s1I+ZBfWo50Mxww7ncLFz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bw6PCSUT; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bw6PCSUT"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12c726ef332so9793624c88.1
        for <Linux-input@vger.kernel.org>; Thu, 23 Apr 2026 11:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776967341; x=1777572141; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pvHA4p32KMCd76eNXkI97f+ghwRdYIBFegcIJqr8FGE=;
        b=Bw6PCSUTTW5eWYP3tu2v578Hvc70jzM2ehWn2sFnwzgEJ0NyNVxOZiZrqFmQNjGmQa
         xzvW0L0YmOIEi+bNnTGIO0CiWiNkOAOHIbsHp6navpXjKjQaB/rZxls1KBYvaxyXwvgc
         s4ZTft6SsDAzK76Qp4soyuUTDI2RWxp4OWTe6ngf1kjkUrM5L6WQBIyh9S50KUZ7xkBi
         2Hpqm3/0dMf/wzwFxUzIEY+6iu5S4dRojI1sJasWg7ijnbskfSVdvJEK/Zd0UHmXRA2t
         SMwEF2E0wG1glbxcqcvXZQpPoV3ctegle9t6W8avcg5e20KUW5chUjqgSotSJxzq5gL1
         2x0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776967341; x=1777572141;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pvHA4p32KMCd76eNXkI97f+ghwRdYIBFegcIJqr8FGE=;
        b=KmkgfIf8Y/lutRzuu/Zg2TWVCP8oAmP3e+8855sd278wbf1D2Kt4FCzE6bQtJMX9nK
         xCr4ljDfeDXK9lhQVdX9F9rsUdNpzfIzSz8sLvsPGX+WsxeQchmzcBhyEL9jcgjAW0jT
         Wdz24ywcmanpZafZAimeCgMe1ZCnIU2iVlVKw/QurubqsaxRjvGdNoDRCt2B/FtqdCD8
         43a7YJ7zqzf9OusRev0mJRHVLvh3R8M99ZRQvib+OnXXE5mteMcLRh13qlKFkbNloRov
         SgSqokex7ikyuKJlWNZAQQ528PypyRpGsUWxmoXAueQLPmdQvEKtIFLdO+bl24l5yoUs
         9CWg==
X-Forwarded-Encrypted: i=1; AFNElJ/Geef9KvtmitpbU1IT6Axmfv3EcczwPspXMTHwqB+Esr+oebLZshoGil1wdeo0AC8uRpL+IoqteEx3WQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9tYJUXDMLU0V9CEVkHFbz482hvllFFwOCGt7ah3W7tqTiey3I
	V/lGB1KFMEDRya9xFCGHx1R4okKQIN8Fk/ekD5dff5j9ijUYVHtxEUuucFUMndy7
X-Gm-Gg: AeBDieufGexb8t+smaE3ZMCZEF7kQcq1bF1NMXd/atOVHtJ5kKhv5Pqh92x1gHzpI6u
	Uabq7K61cQqn+B8xX/N3nIxP5PjdGPZcQaIP+h6lBimuOUbh5GvMw/+p34z1/eir8o1CaQqdZEd
	DftfuoJ6r6V3uSrmb0JlNiwN6+MVt8TcwXCYQBm/X2Nnyg+C/ZDiEgwEInkKRv5EXwxqeMIvrXj
	IU6nOUe3fHyjNNvS1NtupeeL8MAO/gDBhux7RQ6CRMN146iyryggzr9+hr1ZslZKTjRYbglpC9J
	dtflbcxkhauKrfMrnk0W26rp2QjW5y3x8G2TI0hI3npTejrl+CPiF8iuuFOfFr2+WWyjgvbZ/eE
	ZZeATtHwHW8WhzA3zN6K7UAqtBHWJYd04Qym6/d8pJkLW5QTL2VoDyMywJqQuM3kMvMSDPpdUZh
	HfPsKbKFuQ/BQqmFIhsAMA3pHaWthGzRHwy7fe/O9QXfqDEkm/mIDnEH933HLAXZ8f4Ez8cyz/T
	Cg=
X-Received: by 2002:a05:7022:69a:b0:122:2f4:b285 with SMTP id a92af1059eb24-12c73fa37c4mr11973583c88.25.1776967338750;
        Thu, 23 Apr 2026 11:02:18 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:2359:5fa4:9c29:41b1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c74a20eb5sm36223335c88.14.2026.04.23.11.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 11:02:17 -0700 (PDT)
From: "Dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
X-Google-Original-From: "Dmitry.torokhov@gmail.com" <Dmitry.torokhov@gmail.com>
Date: Thu, 23 Apr 2026 11:02:15 -0700
To: Jingle Wu =?utf-8?B?5ZCz6YeR5ZyL?= <jingle.wu@emc.com.tw>
Cc: "Linux-kernel@vger.kernel.org" <Linux-kernel@vger.kernel.org>, 
	"Linux-input@vger.kernel.org" <Linux-input@vger.kernel.org>
Subject: Re: [PATCH] Input: elan_i2c - Add ic type 0x19
Message-ID: <aepelDuMgLKALr-7@google.com>
References: <KL1PR01MB511699853D1B66D137C06806DC2C2@KL1PR01MB5116.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <KL1PR01MB511699853D1B66D137C06806DC2C2@KL1PR01MB5116.apcprd01.prod.exchangelabs.com>

On Tue, Apr 21, 2026 at 07:00:10AM +0000, Jingle Wu 吳金國 wrote:
> The 0x19 is valid 3000 serial ic type too.
> 
> Signed-off-by: Jingle Wu <jingle.wu@emc.com.tw>
> ---
>  drivers/input/mouse/elan_i2c_core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> index fee1796da3d0..7475803c6ce4 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -162,6 +162,9 @@ static int elan_get_fwinfo(u16 ic_type, u8 iap_version, u16 *validpage_count,
>  	case 0x15:
>  		*validpage_count = 1024;
>  		break;
> +	case 0x19:
> +		*validpage_count = 2032;
> +		break;
>  	default:
>  		/* unknown ic type clear value */
>  		*validpage_count = 0;

Applied both, thank you.

-- 
Dmitry
