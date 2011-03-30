From: Joerie de Gram <j.de.gram@gmail.com>
Subject: Re: [PATCH 1/3] input/touchscreen: Synaptics RMI4 Touchscreen Driver
Date: Wed, 30 Mar 2011 13:46:43 +0200
Message-ID: <AANLkTi=jFSrbRaAN57JxRfTyVZTCtB+3jOGPL4yLs=_w@mail.gmail.com>
References: <1301446249-13646-1-git-send-email-cheiny@synaptics.com> <1301446249-13646-2-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46099 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932350Ab1C3LrE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Mar 2011 07:47:04 -0400
In-Reply-To: <1301446249-13646-2-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jean Delvare <khali@linux-fr.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Allie Xiong <axiong@synaptics.com>, William Manson <wmanson@synaptics.com>, Linus Walleij <linus.walleij@stericsson.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>

Hi,

> +#include "rmi.h"

This header is missing.

Joerie
