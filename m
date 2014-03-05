From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] input synaptics-rmi4: rmi_driver.c storage fix
Date: Wed, 5 Mar 2014 09:51:25 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1403050951090.30402@pobox.suse.cz>
References: <1393988899-30076-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55057 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753425AbaCEIva (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 5 Mar 2014 03:51:30 -0500
In-Reply-To: <1393988899-30076-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>

On Tue, 4 Mar 2014, Christopher Heiny wrote:

> Do not use kfree() on storage allocated with devm_kfree(),

I believe you meant devm_kmalloc() here.

-- 
Jiri Kosina
SUSE Labs
