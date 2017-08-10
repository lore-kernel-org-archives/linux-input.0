From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 0/2] constify hid usb_device_id and fix space before '['
 error
Date: Thu, 10 Aug 2017 11:08:28 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1708101108200.30597@cbobk.fhfr.pm>
References: <1502302895-30181-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502302895-30181-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: benjamin.tissoires@redhat.com, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 9 Aug 2017, Arvind Yadav wrote:

> usb_device_id are not supposed to change at runtime. All functions
> working with usb_device_id provided by <linux/usb.h> work with
> const usb_device_id. So mark the non-const structs as const.

Applied to for-4.14/upstream.

-- 
Jiri Kosina
SUSE Labs
