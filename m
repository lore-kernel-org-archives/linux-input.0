From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 12/14] HID: sensor-hub: validate feature report details
Date: Wed, 4 Sep 2013 20:14:41 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1309042014140.3684@pobox.suse.cz>
References: <alpine.LNX.2.00.1308282222190.22181@pobox.suse.cz> <20130829100313.GG7393@intel.com> <CAGXu5jJ4zFJ78=85T6QZDVXZ9GEM_vgbEP4hERjRwQP3RXYkjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39041 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753895Ab3IDSOq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Sep 2013 14:14:46 -0400
In-Reply-To: <CAGXu5jJ4zFJ78=85T6QZDVXZ9GEM_vgbEP4hERjRwQP3RXYkjQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-input <linux-input@vger.kernel.org>, srinivas pandruvada <srinivas.pandruvada@intel.com>

On Wed, 4 Sep 2013, Kees Cook wrote:

> Should this one have been part of the batch you applied? It doesn't
> use hid_validate_report().

It's there [1], I just somehow forgot to send out information mail, sorry 
for that.

[1] https://git.kernel.org/cgit/linux/kernel/git/jikos/hid.git/commit/?h=for-3.12/upstream&id=9e8910257397372633e74b333ef891f20c800ee4

-- 
Jiri Kosina
SUSE Labs
