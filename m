From: Benjamin Valentin <benpicco@googlemail.com>
Subject: Re: [PATCHv2] Input: xpad - sync supported devices with
 360Controller
Date: Fri, 12 May 2017 00:22:42 +0200
Message-ID: <20170512002242.6a8d8a69@nashorn>
References: <20170504231544.335e8f42@nashorn>
        <20170504231714.16ea40d2@nashorn>
        <5f9b48e9-053c-2118-2026-5dcbc7705100@gmail.com>
        <20170505195021.27121915@nashorn>
        <20170506191024.01eefa59@nashorn>
        <842f5c93-9788-2bb9-1ced-bb88ce60d231@gmail.com>
        <20170507215315.GC39686@dtor-ws>
        <20170509025250.28e71f86@nashorn>
        <dbd402c4-b1e5-80da-b9d3-670bb2e0c829@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36520 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756106AbdEKWWq (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 11 May 2017 18:22:46 -0400
Received: by mail-wr0-f193.google.com with SMTP id v42so5369773wrc.3
        for <linux-input@vger.kernel.org>; Thu, 11 May 2017 15:22:46 -0700 (PDT)
In-Reply-To: <dbd402c4-b1e5-80da-b9d3-670bb2e0c829@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Cameron Gutman <aicommander@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Pavel Rojtberg <rojtberg@gmail.com>, "Pierre-Loup A. Griffais" <eduke32@plagman.net>, Daniel Tobias <dan.g.tob@gmail.com>

On Mon, 8 May 2017 22:18:49 -0700
Cameron Gutman <aicommander@gmail.com> wrote:

> It looks like you dropped a few entries from xpad_table[]. With that
> table, I'd rather just list the VIDs and risk a chance it's wrong and
> doesn't work than not list it and guarantee 100% that it won't work.
> If the interface descriptor doesn't look right to us, we won't touch
> it anyway.

Well I'm not so sure about how valid they were.

0810:0003 Trust Predator

actually seems to be a PlayStation Gamepad/Adapter according to the
USB ID Repository. [0]
Game-Debate [1] confirms this. 

11c0:5506 BETOP GAMEFORWINDOWS

is most likely BTP-2175 [2] which can also switch to DirectInput/HID mode (?)
where it aleady works out of the box with Linux [3] so this might possibly
break things. Or enable things as I'm not sure if the HID driver supports the rumble
functionality.
360Controller detects it as Xbox 360 Controller on OS X [4] with this ID, so it might actually
be a good idea to add it back.

> I also have a few name nits to throw in your respin.

I will address those in v3

[0] https://usb-ids.gowdy.us/read/UD/0810/0003
[1] http://www.game-debate.com/gamepad/index.php?ga_id=41&gamepad=Trust%20Predator
[2] https://www.banggood.com/de/Betop-BTP-2175-Asura-Double-Vibration-Computer-Game-Controller-p-1063903.html
[3] http://unsolicitedbutoffered.blogspot.de/2017/04/tested-betop-controller-with-fedora-25.html
[4] http://unsolicitedbutoffered.blogspot.de/2017/05/tested-betop-controller-openemu_7.html
