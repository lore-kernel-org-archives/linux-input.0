From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 2/2] Input: atmel_mxt_ts - allow specifying device-specific
 configs
Date: Wed, 15 Apr 2015 17:58:28 +0200
Message-ID: <552E8AA4.3030703@collabora.co.uk>
References: <1428452770-20767-1-git-send-email-dmitry.torokhov@gmail.com> <1428452770-20767-2-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:36514 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932314AbbDOP6i (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Apr 2015 11:58:38 -0400
In-Reply-To: <1428452770-20767-2-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Nick Dyer <nick.dyer@itdev.co.uk>, Yufeng Shen <miletus@chromium.org>, Benson Leung <bleung@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Olof Johansson <olof@lixom.net>

Hello Dmitry,

On 04/08/2015 02:26 AM, Dmitry Torokhov wrote:
> Atmel controolers are very flexible and to function optimally require
> device-specific configuration to be loaded. While the configuration is
> stored in NVRAM and is normally persistent, sometimes it gets corrupted
> and needs to be reloaded.
> 
> Instead of using the same name, maxtouch.cfg, for all systems and all
> devices, let's allow platform data to specify the name of configuration
> file that should be loaded. This is especially useful for systems that
> use Atmel controllers for both touchscren and touchpad, since their
> configurations will surely differ.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
