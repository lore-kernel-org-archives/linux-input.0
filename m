From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 12/14] HID: sensor-hub: validate feature report details
Date: Wed, 4 Sep 2013 09:05:44 -0700
Message-ID: <CAGXu5jJ4zFJ78=85T6QZDVXZ9GEM_vgbEP4hERjRwQP3RXYkjQ@mail.gmail.com>
References: <alpine.LNX.2.00.1308282222190.22181@pobox.suse.cz>
	<20130829100313.GG7393@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:65282 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755131Ab3IDQFo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Sep 2013 12:05:44 -0400
Received: by mail-ie0-f181.google.com with SMTP id a14so1002445iee.26
        for <linux-input@vger.kernel.org>; Wed, 04 Sep 2013 09:05:44 -0700 (PDT)
In-Reply-To: <20130829100313.GG7393@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, srinivas pandruvada <srinivas.pandruvada@intel.com>

Jiri,

Should this one have been part of the batch you applied? It doesn't
use hid_validate_report().

-Kees

On Thu, Aug 29, 2013 at 3:03 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Wed, Aug 28, 2013 at 10:31:44PM +0200, Jiri Kosina wrote:
>> From: Kees Cook <keescook@chromium.org>
>>
>> A HID device could send a malicious feature report that would cause the
>> sensor-hub HID driver to read past the end of heap allocation, leaking
>> kernel memory contents to the caller.
>>
>> CVE-2013-2898
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> Cc: stable@kernel.org
>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>



-- 
Kees Cook
Chrome OS Security
