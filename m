From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v4 0/3] HID: switch hid-rmi to rmi_core
Date: Wed, 11 Jan 2017 22:20:01 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1701112219350.25515@cbobk.fhfr.pm>
References: <20170105084900.15931-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170105084900.15931-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Dennis Wassenberg <dennis.wassenberg@secunet.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 5 Jan 2017, Benjamin Tissoires wrote:

> Hi,
> 
> Small revision to add irq.h in hid-rmi.c, as reported by the Intel
> kbuild test bot and by Andrew.
> 
> Cheers,
> Benjamin
> 
> Andrew Duggan (3):
>   HID: rmi: Make hid-rmi a transport driver for synaptics-rmi4
>   HID: rmi: Handle all Synaptics touchpads using hid-rmi
>   HID: rmi: Support the Lenovo Thinkpad X1 Tablet dock using hid-rmi

Very nice work. I am glad to finally say: applied to for-4.11/rmi :) 
Thanks!

-- 
Jiri Kosina
SUSE Labs
