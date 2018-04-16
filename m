From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v5] Fix modifier keys for Redragon Asura Keyboard
Date: Mon, 16 Apr 2018 11:49:54 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1804161148370.28129@cbobk.fhfr.pm>
References: <20180411094953.12053-1-rombert@apache.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180411094953.12053-1-rombert@apache.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Munteanu <rombert@apache.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 11 Apr 2018, Robert Munteanu wrote:

> Changelog:
> 
> - v2: modifier keys work, some combinations are still troublesome
> - v3: style cleanup, rebase on top of 4.14
> - v4: remove most debugging calls, make init info useful for user,
>   rebased on top of 4.15
> - v5: fix the HID descriptor as suggested by Benjamin Tissoires,
>   use existing USB vendor id, update comment style, add SPDX
>   license identifier, rename to hid-redragon, stop registering
>   two input devices, rebased on top of 4.16

This should contain the text that goes directly into the git commit 
changelog, therefore should instead contain something like "This adds a 
news driver for HW XX, that needs a specialized driver bacuse .... and 
things to specifically point out in implementation are ....".

Could you please provide that, so that I can commit it?

Thanks.

-- 
Jiri Kosina
SUSE Labs
