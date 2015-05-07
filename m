From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: lenovo: add support for Lenovo ThinkPad Keyboard
 Pro unit
Date: Thu, 7 May 2015 10:31:00 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1505071030450.8186@pobox.suse.cz>
References: <1430511765-28209-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430511765-28209-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jonathan Oppenheim <lejono@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, John Reid <owlman.lists@gmail.com>
List-Id: linux-input@vger.kernel.org

On Fri, 1 May 2015, Benjamin Tissoires wrote:

> This dock is used with the Thinkpad Helix 2 but suffers from an error
> in the report descriptor where an usage max is 65535.
> 
> Add a report fixup for it and make the keyboard working.
> 
> Tested-by: Jonathan Oppenheim <lejono@gmail.com>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied to for-4.2/lenovo.

Thanks,

-- 
Jiri Kosina
SUSE Labs
