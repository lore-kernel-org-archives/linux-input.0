Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836368;
	b=kFzjRXTuV69ol+Pbwsaj7hn3qRSlNTOJMH9nb5TX7+vJwIfqOZ4dv9zd3Q74hqZso/ve
	 W9EtWPv2Oblzz8oA78tt3n6bieS8dasas336d5kZ4u9bFVm5A8EK8j06uOX4wPQHMbIjy
	 cRwYJYypAPkA3Srzwd+14VsAIDJUiCEFLWy2uNFs2OuGwcEOsquYtAqffQNLD/xP1EIaW
	 jWLlJo4B4ygfcHCo1qcFmSQ1cWl0+9euj4IhsCi0mskNqWVArj+ktW5CNeU8NBRnrNyUu
	 Ral2yTAkxTJ5KPg4yj3bKGgF5YItMumgmGokzbp6qA0rhHZAoRREeZu2qPOrHSvo6Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836368;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=GCBkedzgVlQqMi1kz++iUtIpIacOFXvDUza6lGua/T0=;
	b=YlNV0C66Rm5PNMy5bF5iMsxM6kaV9htLap47+on79KGya0A7W2nzJuKlNWOFy4evcIOz
	 AGDAthX0p0cyYT4GK8NVU982iuYnzEYKel8Y4lnAOUpO93HcgNvWSiAGGujEmizSP8ffb
	 G1ft1oNRQj5RKDWCXSjo5qNgCRiAU9uo1U3Thk/11whTBgqLeEPASgtrp/29i5Qi99uuZ
	 fQB/gvTjyZuAGLC9+9gx8AXF717Diw0uUdsh0BU09KtVltIa+jk2dmmyz6uvgQmjzsvoB
	 P8BA6IPbxFx46BzilKgVhPFiqHQJM6OqRglqgYz+3cWiz2Fudx2V+AHwUkEwVLvmfzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=APNcuOLA;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8D4606A326
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 23:52:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D8D4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=APNcuOLA
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1931ff67a29so1594364c88.1
        for <linux-input@vger.kernel.org>; Wed, 04 Nov 2026 15:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793836367; x=1794441167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GCBkedzgVlQqMi1kz++iUtIpIacOFXvDUza6lGua/T0=;
        b=APNcuOLANR3tXkFYFrqmLoAVFs9VbmwMK/1tF/C2bbYpl15hrlGP9+jh8MHtqM41Xs
         wX+ZSp9Y/3Tklu64K+XcpQQUro2nztcBc6Q394I4u87LUdCImgwSEFQVr2qAvdYnBPtM
         Cu2C4HKZseSvAcqJNy+0ZYjREj0DyjWd6qdAkGOfjmT6AdA+Z6ASOtrF0eMUC85aHhAh
         S2HlDXsFrSfvY9obHVU+CX2YdkXbcz+TdxsmYflz247QFwgmMcGNL1hwKsqDKMSlwBP3
         mMcsMcIr7FmFC6EsKeZbFotAEeKF8iCsOhcgZwIft+Edp0A7rGP9iIDDN1sW6kMij4IK
         H4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793836367; x=1794441167;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GCBkedzgVlQqMi1kz++iUtIpIacOFXvDUza6lGua/T0=;
        b=dS4XIRj09bTmGTCpzsEiQc5WLvQop+qT6cfoZo2iZ/0TbjE9IZFDD5tVh18Xg+ope+
         thKlSFaWb+nY5h/xoAFHAJh+jUXbPkybVQE+hhKWtnxCjmpI5fk8B4czWWCUxeFSl7Vc
         XWNMSCarENq5mRoix0SMteszcXvg4IKDBCTjoxYWcY/I1gD9mJhJIbTaPr208tOduB/B
         v7wbtZ7dmf2XMe/yWYKukVcAqjua5LAvMbT0w6/ZviGEJwPsKvuPFtSRNds2zgh4aN+1
         4KXOeSe3efRNEilbyVeESqcX9Nz+FvgY7Z8waeuvQNecDphKMHxA5IOZ0sxz+eRmnGg/
         r/jA==
X-Gm-Message-State: APuU4Z8yShhrD0KD2mnCZ9m7qUmCFu9H0hz5CQGSNweGPWJzqXq8Hl2b
	5Ehw7VIK459t8CzIN5mq6cxCHcVZMmeyfDhDgnrwjMRFUixqb5VByOZQ
X-Gm-Gg: AYBFou0X0j+htKBpG58W+ep6O2nK9D8Bqyv0qqqvW6DQMCtN8cfUW3ltwfGgR6vmhTj
	06NYgOlRt6ToMJYLZAMxcPsLVfUFN4fInY1GEEY4fGB7MUSgz4AakPQhid8z2+XYA4zq0PjiwHy
	ObG1hvKjqLpw6UCKOandVNqDai40/3QXImz0lgChQF91i7b0DgQX1HT+xVW9OigUpeX7BxqV2OK
	0Gz11xFFAAg5J7buOUYuByJ6/tsa1RgtQ7nz6Gu5YCygNP5lfyXQ6/u7fsAj5I8jJ5Nn4YNyCwZ
	ww1DJ3E2TqO0qHzvmyfL4DMrTofJ7dampTVprZR3zW+ucCH4wc32D7j2muXmbuGcF6evK5i1USX
	DiWmYdkmPleCvR3QB3jZWSBF8wW58DSCOnC2Pq7hh2VQPrf8GRB6vxOrjZRTFwQDGN5F1f8EGJ+
	y2lPrRk3r0c/TLd0w7AMEelGcqxXI2n1rh26rD3D7+7Ml7pmcXJAdn1q/BagGVr2z5DeSVCEd2I
	/nG/NLKqX+pvrIT9wKktqnbTHtzi1UaP5Mf9rBN/KUThbxPyV9anG3rNu0SfPvNLu5u2219tT53
	JduZd7Q9tbwmFl/TrmGZ3ySjd+5ZoGvMGGhuRY+jqxPY0vrmzUkBQiQABdO8qPBup+vjVXnwie0
	9i0/q4X3cPnXnvCY=
X-Received: by 2002:a05:701b:428a:20b0:17b:fed6:7449 with SMTP id a92af1059eb24-1ac5da7725fmr28530265c88.47.1793836367131;
        Wed, 04 Nov 2026 15:52:47 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:c8f4:b7d9:252f:4483])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca39c5f0csm10107500eec.29.2026.11.04.15.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 15:52:46 -0800 (PST)
Date: Wed, 4 Nov 2026 15:52:43 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	liuc63@xiaopeng.com, stable@vger.kernel.org
Subject: Re: [PATCH] Input: mt6779-keypad - check the reported row and column
Message-ID: <auvFSNx_RS60_tO0@google.com>
References: <20261103084135.426629-1-zhugl3@xiaopeng.com>
 <20261103084135.426629-6-zhugl3@xiaopeng.com>
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
In-Reply-To: <20261103084135.426629-6-zhugl3@xiaopeng.com>

On Tue, Nov 03, 2026 at 04:41:33PM +0800, Guanglei Zhu wrote:
> The interrupt handler turns register bits into a matrix position
> and indexes the keycode array with it:
> 
> 		keypad->calc_row_col(key, &row, &col);
> 
> 		scancode = MATRIX_SCAN_CODE(row, col, row_shift);
> 		...
> 		input_report_key(keypad->input_dev, keycode[scancode], pressed);
> 
> The keycode array is sized after the rows and columns the device
> tree declared, but neither the probe nor the handler checks that a
> reported position actually fits those dimensions. A register glitch
> or a matrix smaller than the hardware's fixed layout indexes past
> the array and reports whatever sits there as a key code.
> 
> Skip positions outside the declared matrix.
> 
> Fixes: f28af984e771 ("Input: mt6779-keypad - add MediaTek keypad driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>

Applied, thank you.

-- 
Dmitry
