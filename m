From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 2/2] HID: logitech-dj: break out testing of validity of
 dj_device
Date: Wed, 27 Aug 2014 23:06:25 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1408272305560.21233@pobox.suse.cz>
References: <1408738566-6805-1-git-send-email-benjamin.tissoires@redhat.com> <1408738566-6805-2-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1408738566-6805-2-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 22 Aug 2014, Benjamin Tissoires wrote:

> We can do once the test of the validity of the dj_device, which removes
> some duplicated code in various functions.

Queued for 3.18, thanks Benjamin.

-- 
Jiri Kosina
SUSE Labs
