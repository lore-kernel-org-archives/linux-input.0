From: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH V2 1/1] Drivers: input: serio: New driver to support
 Hyper-V synthetic keyboard
Date: Mon, 23 Sep 2013 23:08:12 +0200
Message-ID: <20130923210812.GA19953@aepfle.de>
References: <1379460418-1523-1-git-send-email-kys@microsoft.com>
 <20130918210107.GA32320@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:52292 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752980Ab3IWVIQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Sep 2013 17:08:16 -0400
Content-Disposition: inline
In-Reply-To: <20130918210107.GA32320@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, apw@canonical.com, jasowang@redhat.com, dan.carpenter@oracle.com, linux-input@vger.kernel.org, vojtech@suse.cz

On Wed, Sep 18, Dmitry Torokhov wrote:

> This looks much better. Could you tell me if the patch below (on top of
> yours) still works?

The help text is slightly incorrect, its a dash not underscore:
drivers/input/serio/hyperv-keyboard.ko

Olaf
