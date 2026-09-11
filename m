Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C548472098;
	Fri, 11 Sep 2026 15:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141114; cv=none; b=AW8bVkS0tbE4es5b0i9HNhEoRcRbnP2lbqofpqNOzznaXaX9Xaq7tetWg3v9x9NN904YLyi5hXf79uVeIOM5MsOmmEdk0EMjaH5J0awvdo72MmzyD8IHAyO/YSPR0XLPlaIkoFpzxwtneW2X3oVZJesoIsOIJfcvJ0+Fxu/WO9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141114; c=relaxed/simple;
	bh=fGt10FnFyDLRx4kwIbhvfMPdsw51n4rmn+6/Td4gOP4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qrd5i5tz/2YJxqy8le5K7EPUpmubEXihU4Pgp3dIwZtnK/ty4yPMdtN+C+YdM0OdicSnHJKtgcSzqZFDsSZFK342Y7CxIUOvtrnAs38Ui2PLccTLMdbMBOZcvdFtKpb6g0cy25G/Dvbj7aH1VTcN75lePcx++R6Y8UxGvhKCXiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbxOPoYw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbxOPoYw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7A61F000FF;
	Fri, 11 Sep 2026 15:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789141107;
	bh=7Bq+ncT3/4d3sU066qKQheB1ok+7UPyv7WtRbs2+Vug=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=GbxOPoYwCFXz0A+VWv5BHFn3I+mbbUVEA5fLIMZUPWPic4HDxAi9h8zbvtJTbJDmp
	 1B5fKMgyJ7yhWIiMO7cflIrYuGBtwFPjQ5Gd5v3cSntEZlKdbGsQVkJgFplZx0iU37
	 vGeg9GrCHzyySIt5ubEWLJLqap/UME7tlnKsLms18+7W3DgUSOcB/MY+Ta/fftctoQ
	 cCJ9bkxCczdv7HMkxNtJ+iMBs3NPaashGuCKyJvHsE4qGLPZN/9JreEe7kZBRyEnez
	 ubg934dEJjNLx0sFa9j/xJcJoe8Zh8moiWp+07ztNfeV2WXd/OukROJd9JsZpB81m/
	 +HrQsjZrQF1jQ==
Date: Fri, 11 Sep 2026 17:38:24 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Justin Yeh <justin.yeh@mediatek.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Matthias Brugger <matthias.bgg@gmail.com>, 
    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
    Douglas Anderson <dianders@chromium.org>, 
    Maxime Ripard <mripard@kernel.org>, 
    Project_Global_Chrome_Upstream_Group@mediatek.com, 
    linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] HID: i2c-hid: Unfollow the panel on shutdown
In-Reply-To: <20260908013843.368364-1-justin.yeh@mediatek.com>
Message-ID: <n9rrn4p0-9ro3-00r1-r00n-n70s38p3o05n@xreary.bet>
References: <20260908013843.368364-1-justin.yeh@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 8 Sep 2026, Justin Yeh wrote:

> i2c_hid_core_shutdown() sends SET_POWER(SLEEP) even for panel followers,
> but nothing in device_shutdown() guarantees whether the panel, and hence
> our own power, is still on by the time we get there.
> 
> Do what i2c_hid_core_remove() does and just unfollow the panel.
> drm_panel_remove_follower() calls panel_unpreparing() only while the
> panel is still prepared, which powers us down properly; if it is already
> unprepared no transfer is attempted at all. On MT8196 the panel is
> unprepared long before us, so this also drops the ~2s i2c bus timeout
> from every reboot.
> 
> Fixes: 96a37bfd232a ("HID: i2c-hid: Support being a panel follower")
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Justin Yeh <justin.yeh@mediatek.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

