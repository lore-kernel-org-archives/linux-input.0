Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C182206AC;
	Mon, 23 Feb 2026 04:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771821677; cv=none; b=lBlW3Fa1fpYbZwkPrzQzwSa/QORKxWkiLPoNOgGlhkMDNsokWq3S+W3wCjcI9+K5MalSZafJmNitpByXi7K1BzrLXc+ZGmCQFX2p63uFo6+oUWOC25Qxle7wjykcUVLhWO9PhtK5/DloeqjYAAhxOLvLhrG3G2ckJ4YesMjs0Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771821677; c=relaxed/simple;
	bh=+vbRvTWnzjslPM7ZHa0Ey6LfIS5fIcWJU/+gSX36wIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVtUHsC9N1jB0TiiA9/cQUlwMJGUx2+BYaFwejEctLvvv1PiV7v/TnTHDETPtlaEZIRio0yoIJGruCzZtJD9O/ueZfxfHJffIBjJj12dnDwbO+3/QnqKC3LFFDLbsPKpxUHLd2bQdnpkewboCSTox0b3PER1TdXe7Z/SgTIW/Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvKz0t0k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvKz0t0k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A10C116C6;
	Mon, 23 Feb 2026 04:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771821677;
	bh=+vbRvTWnzjslPM7ZHa0Ey6LfIS5fIcWJU/+gSX36wIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fvKz0t0kps2OCCkLft0GoXulCr0dif8s6FXfy34WUwVl8Azm4zKqTGNl+oY34Njxf
	 LFpPKd3vSf4MjWy9URBrDVkiw1+yOXlicHJEF1zqU+A2/AQ3H2Ovi6yk+ax0sDk3hr
	 lpPnm24n6/Rz600C6hP1fni+3ZmH/IITWno7JsSQwvUlTw+sMxtuwL2UIcEJeGYtP2
	 ZpZQAOkfzayJjrYrnD5+EMC/CJaq+unJZ80JX32vt6a/MAQtX8w+ivYHAz1vJFIZ/G
	 3dPHSzszgIIrlquD1XZ82Gsm7uIoiPGx4p8eodaO7wDDjia18IvfQ2yq+C5rFnsJm+
	 U9JGQsJ/vQJDQ==
Date: Mon, 23 Feb 2026 12:41:13 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Fabio Baltieri <fabiobaltieri@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, Simon Glass <sjg@chromium.org>,
	linux-input@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] Input: cros_ec_keyb - simplify cros_ec_keyb_work()
Message-ID: <aZvaaY_2iwtrWAxo@tzungbi-laptop>
References: <20260222003717.471977-1-dmitry.torokhov@gmail.com>
 <20260222003717.471977-5-dmitry.torokhov@gmail.com>
 <aZre0qH8rMcSJsa6@tzungbi-laptop>
 <aZvOVKUkPBinrSvm@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZvOVKUkPBinrSvm@google.com>

On Sun, Feb 22, 2026 at 07:49:54PM -0800, Dmitry Torokhov wrote:
> On Sun, Feb 22, 2026 at 06:47:46PM +0800, Tzung-Bi Shih wrote:
> > On Sat, Feb 21, 2026 at 04:37:13PM -0800, Dmitry Torokhov wrote:
> > > @@ -376,12 +378,10 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
> > >  		pm_wakeup_event(ckdev->dev, 0);
> > >  
> > >  		if (ckdev->ec->event_data.event_type == EC_MKBP_EVENT_BUTTON) {
> > 
> > This can also be simplified: `event_data->event_type`.
> 
> Indeed, will update.

Feel free to use my R-b tag after applying the change:
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
