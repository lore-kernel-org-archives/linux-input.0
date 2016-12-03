From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 0/7] RMI4 cleanups and switch hid-rmi to rmi_core
Date: Sat, 3 Dec 2016 10:32:04 -0800
Message-ID: <20161203183204.GD38119@dtor-ws>
References: <1480678916-6469-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34263 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbcLCScH (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 3 Dec 2016 13:32:07 -0500
Content-Disposition: inline
In-Reply-To: <1480678916-6469-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Lyude Paul <thatslyude@gmail.com>, Nick Dyer <nick@shmanahar.org>, Dennis Wassenberg <dennis.wassenberg@secunet.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Dec 02, 2016 at 12:41:49PM +0100, Benjamin Tissoires wrote:
> Hi,
> 
> Well, the cleanup part of the series has already been applied, so
> I guess this is just "switch hid-rmi to rmi_core".
> 
> The series applies on top of Dmitri's synaptics-rmi4 branch
> 
> However, as mentioned in v1, I'd like to get some testings from actually
> integrated devices befor we flip the switch for HID. Andrew, Dennis?
> 
> Function f03 has been tested in the rmi4-smbus, and the attn data API
> on a test synaptics board.

So I applied all Synaptics changes to my synaptics-rmi4 branch, but what
do we do with HID changes? Jiri, do you want to pull this branch or do
you want me to apply HID changes? Or wait for the next cycle?

Thanks.

-- 
Dmitry
