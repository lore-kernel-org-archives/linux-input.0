From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH v3 0/6] HID: sony: Add full Bluetooth support for the
 Dualshock 4
Date: Wed, 12 Feb 2014 13:14:45 +0100
Message-ID: <CANq1E4TNzAuhUsTi_QA-NaqH2MbzS3awuJu0Tx0QyeL-MEBrmA@mail.gmail.com>
References: <1391648629-3077-1-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:53694 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbaBLMOq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Feb 2014 07:14:46 -0500
Received: by mail-ig0-f180.google.com with SMTP id m12so10843135iga.1
        for <linux-input@vger.kernel.org>; Wed, 12 Feb 2014 04:14:45 -0800 (PST)
In-Reply-To: <1391648629-3077-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

Hi

On Thu, Feb 6, 2014 at 2:03 AM, Frank Praznik <frank.praznik@oh.rr.com> wrote:
> v3 of this patch series rebases the code against Benjamin Tissoires' HID
> transport layer changes to use the safe inline hid_hw_* functions which
> eliminates the need to check the function pointers manually.
>
> It adds an explicit Bluetooth initialization function instead of the controller
> input report state being set as a side effect of initializing the LED system.
>
> It also uses a new DUALSHOCK4_CONTROLLER macro to simplify conditional cases
> where the connection type is irrelevant.

The series looks good to me.

Reviewed-by: David Herrmann <dh.herrmann@gmail.com>

Thanks
David
