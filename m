Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AC638DC5A
	for <linux-input@vger.kernel.org>; Sun, 13 Sep 2026 23:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789341333; cv=none; b=f7WekiNgUfdxYvCu1dufiQq6uQOpRBbDbqYtpBGbj9iMM/7w0uUXIwvIShigAyMgrR9gZXLE+xBqN0KyjqxxZGAWnzigS61LiA4o1xqiJI1tsNJ5/DxnOMXOO0LPXo1naVHsuhAPaiaM7iQlHs0OBFL5dDlCpT+nEarYh7HzeIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789341333; c=relaxed/simple;
	bh=gVYP12sqP6cJ+L+kakkU6p/W4lSVK4Q+ekoCezDUg6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4D5a4HN/KVBLr+SQkknDSPLnhJMETCLHJe4bfGjAatM/DCoCSD5noSV0Mkw1xfFWPlirM3x5S90lqwlGLoPP6tK4rgwGUydbT5uQPw5m+pCOcMbSG7rx4pzSnAKhBO3Zcet2UiFfWMZdw5QTv6QY9ZiuSEDBBVGIDKnDGpvAAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rWPdYgWm; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWPdYgWm"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2db858d60e0so23752015ad.0
        for <linux-input@vger.kernel.org>; Sun, 13 Sep 2026 16:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789341330; x=1789946130; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f2kOvL/0PNO2AiawOfNAM0hHfx3xmVfEalLZGZRZApc=;
        b=rWPdYgWm77huGUFH1JCxeGWBs+dQ4WuhnmnnwedkpHepgI1b93t5Mlu0iPzMOBlAZy
         UQQuxDkDkPUwjgbbHVW8Xhg7f3jA5Mj2nvjZb+9oRSGuLUmTM98xLtL54DdFgEv1m8Vq
         HroSmCE9Ker7TO13OtEijHlye2vnTZnRJGjUV7rRRejbIV1HapFM4+daE5F/uP3tlNYU
         oLqCgsE3F3bHxF78pG0YZbQeflhCJ5GI7OCWl2s2gvo74qgY57Z5Sd71LgPJ8RT/CbT9
         5u/ZDyqWZ5ODZBOXr7HShlZm3D6XnZJ/njRVPzaaAzYc7rRt9Ae35k2umlpTCssOFaqY
         vJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789341330; x=1789946130;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=f2kOvL/0PNO2AiawOfNAM0hHfx3xmVfEalLZGZRZApc=;
        b=RJT/P9Mbr8L9ZKBVDAsa/IRJZWr+Kg+amTd6pIBGqkxKEbXOKc+h6Xet6/+gCAHLp4
         iVtwawxSDUetg1irPr8wqpE/CtrPDBoZdczB6S+2TqULafRpyopDQtgFqlGwe+AMZNNB
         Ik1X1B6XTDBh39aG3AyhSfRIdofXRLEqJdAZ5tuDelLcCG7N1awslvkVm+gHqt7R0h4O
         /s9y6M3A94vwN+fin8K5oA4QjojNf56rhZJDYn6x2ZULOSQc2JtAMvBJqnGvKrGIUFph
         y01tSXKEZ0+xJ03jB/cIQbsU+Y020Z/uJY6vERo+YiqD91SQGy+DGvxA3M1/IS1W9vYc
         B8Rg==
X-Gm-Message-State: AFuF++m+wm+PDgYhmahtd0PItw5ArG9rURfrS5RZIpJxOIbBAu4Uz/gs
	LYrXG2EzI7YSKhqv6JLY8lRBjQquanIRJuG/p+GA06XQGl95qMNoxCXk
X-Gm-Gg: AYBFou1DMUeClFfYDnscBeoaa3ARIdqO6SyfaQjR4ccJtbmAk5polxAca3VaXRC/sHJ
	pZ5MDJQ7ae8++oBEBgeuIxrty0c2k9uXMyn5fqGAwO9iYhSOKhoTq5fEkuf6uzOxpBL9ApcumXb
	bsRmLp2yYRAGeubSROYBgGJED5ntoeSLyqXdVMeEGNgKYu2ZkFYoq5MO1WCCNKrwAJaBiMQyKYD
	o+IoCBkpKLd1HotI6+E+FPAzdXjzEL2/Ik/4avmQ+NUUTKH4UFHMY4Khf043/m7SgqfNmKTp6Y6
	yatpGytSpYFJR70vmjwmuGulQLxUE9Gp5Dhsq2CCdr6TOMacpIyrtYrFO5NjhWRb0eCHlzYfiAP
	qwxHV/0NpW2nxP4SlzdINzAC12jXLx/hqkvDyw8+v+JBlP0HaGrFk1o04vLn4lV1EPPuSocKKSZ
	mTp86dP6WRucNoRGWhb4xOewtNK905tEEFdjnoZUVQLY3KngbEwSnqh4PFYMWrGhm5E08h4uqSB
	lpv1fshvYvENR94UKiaGaIHH4WcEo4b1X65HGMw
X-Received: by 2002:a17:90b:288a:b0:39d:e43c:5a0d with SMTP id 98e67ed59e1d1-39debfc0f51mr271711a91.8.1789341330359;
        Sun, 13 Sep 2026 16:15:30 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a739:376c:7eb4:ea2d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bc03778c7sm11934175eec.9.2026.09.13.16.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 16:15:29 -0700 (PDT)
Date: Sun, 13 Sep 2026 16:15:26 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: =?utf-8?Q?Rapha=C3=ABl?= Larocque <rlarocque@disroot.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 RESEND] Input: synaptics - disable InterTouch on
 ThinkPad T440p (board id 2722)
Message-ID: <aqcuip73GJZc6TsM@google.com>
References: <20260910164425.12832-1-rlarocque@disroot.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260910164425.12832-1-rlarocque@disroot.org>

On Thu, Sep 10, 2026 at 12:44:25PM -0400, Raphaël Larocque wrote:
> The Lenovo ThinkPad T440p (PNP ID LEN0036, board id 2722) has a
> Synaptics touchpad whose SMBus companion is not ready at boot and
> takes roughly 200 seconds to appear. During this window the touchpad
> and TrackPoint are completely unresponsive on approximately 50% of
> boots, making the machine unusable until the companion finally
> registers.
> 
> The device is in the topbuttonpad_pnp_ids[] SMBus allowlist, so the
> kernel attempts to use SMBus/RMI4 mode by default. When the companion
> is not ready, psmouse_smbus_init() leaves breadcrumbs and returns
> -EAGAIN, the PS/2 fallback path is taken, but the device does not
> function properly until the companion appears and RMI4 takes over.
> 
> Disable SMBus InterTouch for board id 2722 so the touchpad and
> TrackPoint work immediately via PS/2 from boot. Users can still force
> SMBus with psmouse.synaptics_intertouch=1 if needed.
> 
> Tested-by: Raphaël Larocque <rlarocque@disroot.org>
> Signed-off-by: Raphaël Larocque <rlarocque@disroot.org>

Applied, thank you.

-- 
Dmitry
