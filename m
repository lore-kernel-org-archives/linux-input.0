From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 2/3] HID: sony: Set INPUT_PROP_COMPOSITE flag on sub
 devices.
Date: Wed, 23 Aug 2017 10:50:05 +0200
Message-ID: <1503478205.24498.13.camel@hadess.net>
References: <20170818020156.23390-1-roderick@gaikai.com>
         <20170818020156.23390-3-roderick@gaikai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:58680 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753496AbdHWIuI (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 23 Aug 2017 04:50:08 -0400
In-Reply-To: <20170818020156.23390-3-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roderick Colenbrander <roderick@gaikai.com>, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Thu, 2017-08-17 at 19:01 -0700, Roderick Colenbrander wrote:
> From: Roderick Colenbrander <roderick.colenbrander@sony.com>
> 
> Configure the touchpad and motion sensor sub devices with the
> INPUT_PROP_COMPOSITE flag. This flag will be consumed by joydev
> to filter out the motion sensor device.

Could you please add the same to the hid-udraw-ps3.c driver?
