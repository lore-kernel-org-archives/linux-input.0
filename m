From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 0/3] HID: lenovo: Improve wheel emulation
Date: Wed, 12 Aug 2015 14:36:06 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1508121435120.27871@pobox.suse.cz>
References: <1439329252-16809-1-git-send-email-jm@lentin.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439329252-16809-1-git-send-email-jm@lentin.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jamie Lentin <jm@lentin.co.uk>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 11 Aug 2015, Jamie Lentin wrote:

> A collection of unrelated patches to improve support for the Thinkpad
> compact keyboards. The first 2 are just cleanup patches.
> 
> The final patch alters the behaviour of the middle button so userspace
> either gets wheel events or a button click, not both. This stops
> browsers opening a link in a new tab as well as scrolling, for example.
> 
> This means you can no longer long-middle-click, but I don't think this
> is likely to upset users as much as the current behaviour.

Makes sense. Let's see whether we receive any complaints about it (I don't 
expect that).

Applied to for-4.3/lenovo.

-- 
Jiri Kosina
SUSE Labs
