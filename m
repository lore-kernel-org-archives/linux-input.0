From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 12/14] HID: sensor-hub: validate feature report details
Date: Wed, 4 Sep 2013 11:26:24 -0700
Message-ID: <CAGXu5jLf+8A8jS5fbj=LOhAfBpGJ8Ef8OcsCOWfvAe+jcfB0Uw@mail.gmail.com>
References: <alpine.LNX.2.00.1308282222190.22181@pobox.suse.cz>
	<20130829100313.GG7393@intel.com>
	<CAGXu5jJ4zFJ78=85T6QZDVXZ9GEM_vgbEP4hERjRwQP3RXYkjQ@mail.gmail.com>
	<alpine.LNX.2.00.1309042014140.3684@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:43177 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754111Ab3IDS0Z (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Sep 2013 14:26:25 -0400
Received: by mail-ie0-f170.google.com with SMTP id 16so1280930iea.29
        for <linux-input@vger.kernel.org>; Wed, 04 Sep 2013 11:26:24 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1309042014140.3684@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-input <linux-input@vger.kernel.org>, srinivas pandruvada <srinivas.pandruvada@intel.com>

On Wed, Sep 4, 2013 at 11:14 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Wed, 4 Sep 2013, Kees Cook wrote:
>
>> Should this one have been part of the batch you applied? It doesn't
>> use hid_validate_report().
>
> It's there [1], I just somehow forgot to send out information mail, sorry
> for that.
>
> [1] https://git.kernel.org/cgit/linux/kernel/git/jikos/hid.git/commit/?h=for-3.12/upstream&id=9e8910257397372633e74b333ef891f20c800ee4

Ah-ha! Okay, thanks. :)

-Kees

-- 
Kees Cook
Chrome OS Security
