From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v3 0/4] Input/HID: introduce joydev ignore feature
Date: Fri, 25 Aug 2017 10:49:49 +0200
Message-ID: <1503650989.12938.10.camel@hadess.net>
References: <20170824231153.8809-1-roderick@gaikai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:34753 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755075AbdHYItw (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 25 Aug 2017 04:49:52 -0400
In-Reply-To: <20170824231153.8809-1-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roderick Colenbrander <roderick@gaikai.com>, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Thu, 2017-08-24 at 16:11 -0700, Roderick Colenbrander wrote:
> From: Roderick Colenbrander <roderick.colenbrander@sony.com>
> 
> Hi,
> 
> This is a revised version of a patch set, which was originally meant
> to prevent devices ds3/ds4 motion sensors to get picked up by joydev.
<snip>

It's all nitpick and wording problems for me.

Dmitry, you can add:
Reviewed-by: Bastien Nocera <hadess@hadess.net>

to the whole patchset once you're happy with the wording.
