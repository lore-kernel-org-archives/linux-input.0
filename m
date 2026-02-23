Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6DF338910
	for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771869315; cv=none; b=Fwj5x4hkjNYmrNJ6fYuDz0CG+kBg2gbVtk7ey1pzNzIX9wz5ujGkdvbdW13LdY8DS/obpZHD9M4b/ugMwzrlDjfcXaRS2NiHuR7MHapAAUyTlQdiZA5M+zFhZsua8Wp47OfoLYzq1z5CoTgG5JEdgdTjcwIvYVmAP990UQrOaOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771869315; c=relaxed/simple;
	bh=JF1KZ8us1B4UC6UAm56h5UA3Lh/N4+4s3jylcnX4xUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlImLXUn9Q+dFKurL4Ql64JIwy8EMSkYTqRw+xU4Gp3r83MHOLhBRqfO96wihHvGjoP/Xl41dERSd/HabW63dLtY0Z02FoN+SUeOe3zQbpVumvb5YtuFQmqgqnrsPp3KkNk+UwFWzqC4VrUyEZ5r9tStjKms4ACouhuPM2vcblk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dH3ig7Dc; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dH3ig7Dc"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1271195d2a7so105402c88.0
        for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 09:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771869312; x=1772474112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8S3D2amG83bMjq3rYrixdtz5QNwrXVFuIOF99KB48r8=;
        b=dH3ig7DcgoD2/IW68Ckw0bdharNJTHMFc8etCmoR7iPRba+y5eJ54Y/r9E7U/Iuhod
         Ldi7g3QsXsNHLG/DmGqqjxwdZ9JL40yDti4z6Nc2tM7xmz8HnDo6RWArOd3yX0fz5Hsd
         xjDXOs8dtiFrX/7NHm3illACfYNA9365Qet69FJ5E8x8HVGAevDgBcbxjwiG6JJX4GQG
         4q9ElXskCyiGdnCjF7jYImsZyd3+vA8sSie3IHYr6H/nv5Y76UwBX0a3MPhNq+4AHVa9
         UutxyWd5vr9DxURjxnQDQsygsoC8EgZzOM1gJb5Q6yFuWuPmSh0yJT4oiF2hOGJkAQDZ
         X9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771869312; x=1772474112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8S3D2amG83bMjq3rYrixdtz5QNwrXVFuIOF99KB48r8=;
        b=GPIRbx3UFIgUfuMheA1BVCO08bRWH9d1nTzrzeHkhrza7qFRi9/aPStiD6aloG4Jvn
         LDwht94jqA+ijiAPzX6jgpCqbm3b1vHnnGVe07nO03h0gahw1mlz4XDw8nMN9DFmhyJ0
         MVngYo8z7bMK4rlJ7n0OvVhzlh1qPReS3BYZlRZy+/UGmm5Xe5Jen9gCfEVmMIcox3dD
         D2GdqvTaEezPeBrDmqL7JaGEAUs5DGvFFHt+xAM0ke9VKhyvIam8kxShHtBr4AMsUtYn
         8dK3r+/qABcNPOpq0G9LReCkKZHoeEG1bOFpqqTAHROnHaHpyEzxcMiitLoqp9SQh0at
         0dqA==
X-Forwarded-Encrypted: i=1; AJvYcCUojk0VQ8uHTcOMqlcqWy3GbeAsYGeIOixncjDH42RxH4QYa0FpvGpahAsmqhc9kMA9UZxoLv+qrV2ynQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrr7Wf0KP7GPhmD1Dq4B0TRxvKfLNa+/Dwh/9xs6lTAT77pP98
	NdWydRZ+oTwjjZaJl6nnN8D2qJPH3/zwuew5uGWgsMjlijHE9stTfs6R
X-Gm-Gg: AZuq6aI7ABjL2Hx9VVYeL7dZsNQgD2Neo+I2SvfE3A40NcVXpw9bqR2pKuT2JTqxOfb
	ZUYFvFel1GHjLSeopHB5l0+hJVGB8SYIwKX2Vba433H+7d5/7IlPkVGfqyWJUv5UyC7TewATXOm
	4t/SSDcHL+D9rCHJWheMg6RZ1OLz3gI7wwvQqz+sbSBemwsNfTWaASKbzzJEfovqamGJXmyIK4p
	LM85HOAiq2R+xbdowuKt+mDf/zPo0t/gWVqTtxEad7z7bSPm68p9nWYlPwQAKOEU43XyXl8MSwA
	w3BlRXtcIkeOPBF2wzIjV5N2PDv+5EazPZcfrAdzEiejxnzRyc54cwHOU/tl7txQHnayU1XQsvX
	eI7j/rnhiwlOBKtstzRo4MbvT9aZGpLGNsnJ9AMWsKTEbRX/AcHonn8YPX+QeTsChRM9B59Hzyq
	ft15F/O7tBNi5Ix8aI0odFk/qe3Z+x7/ev0z4lYvxCcWtUlz7jtabnTU713OBSTmhoA6fj2yx0s
	sE=
X-Received: by 2002:a05:7022:2214:b0:11b:9386:a3bf with SMTP id a92af1059eb24-1276ad61a70mr4534016c88.42.1771869312175;
        Mon, 23 Feb 2026 09:55:12 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:1b48:5d6e:ab6e:5287])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af7ad65sm7334624c88.11.2026.02.23.09.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:55:11 -0800 (PST)
Date: Mon, 23 Feb 2026 09:55:08 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, Val Packett <val@packett.cool>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Eddie Huang <eddie.huang@mediatek.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Gary Bisson <bisson.gary@gmail.com>, 
	Julien Massot <julien.massot@collabora.com>, Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, 
	Fabien Parent <parent.f@gmail.com>, Chen Zhong <chen.zhong@mediatek.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH 7/9] input: keyboard: mtk-pmic-keys: add MT6392 support
Message-ID: <aZyUXip4zgeDUdVQ@google.com>
References: <cover.1771865014.git.l.scorcia@gmail.com>
 <2c96591313084d240ac94b9d42d91d984fa9bce7.1771865015.git.l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c96591313084d240ac94b9d42d91d984fa9bce7.1771865015.git.l.scorcia@gmail.com>

On Mon, Feb 23, 2026 at 05:12:46PM +0000, Luca Leonardo Scorcia wrote:
> From: Val Packett <val@packett.cool>
> 
> Add support for the MT6392 PMIC to the keys driver.
> 
> Signed-off-by: Val Packett <val@packett.cool>
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Please feel free to merge with the rest of the series.

Thanks.

-- 
Dmitry
