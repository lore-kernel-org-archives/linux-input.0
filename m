From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: get rid of HID_QUIRK_NO_INIT_REPORTS
Date: Mon, 23 Jan 2017 15:15:36 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1701231513240.25515@cbobk.fhfr.pm>
References: <20170105092144.17120-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170105092144.17120-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Herrmann <dh.herrmann@googlemail.com>, Oliver Neukum <oneukum@suse.de>, Jason Gerecke <killertofu@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 5 Jan 2017, Benjamin Tissoires wrote:

> I don't know what to do about hiddev too. I don't know if we have actual 
> users besides some debugging tools. And hidraw is much better than 
> hiddev, so ideally, I'd like to remove it some way.

First, I'd love to get rid of HID_QUIRK_NO_INIT_REPORTS; I am 
whole-heartedly convinced that initializing reports was a big mistake to 
start with, but changing history is hard :)

Regarding hiddev -- there actually are 'legitimate' non-debug users; for 
example NUT (UPS management software) has been using it last time I 
looked. I am pretty sure there are more.

So we'd rather be careful not to break hiddev by default.

I'll think about your RFC a little bit more.

Thanks,

-- 
Jiri Kosina
SUSE Labs
