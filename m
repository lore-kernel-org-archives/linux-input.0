From: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] HID: remove initial reading of reports at connect
Date: Tue, 21 Mar 2017 15:00:32 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1703211500160.31814@cbobk.fhfr.pm>
References: <20170308141114.9200-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170308141114.9200-1-benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Herrmann <dh.herrmann-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>, Jason Gerecke <killertofu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, 8 Mar 2017, Benjamin Tissoires wrote:

> It looks like a bunch of devices do not like to be polled for their 
> reports at init time. When you look into the details, it seems that for 
> those that are requiring the quirk HID_QUIRK_NO_INIT_REPORTS, the driver 
> fails to retrieve part of the features/inputs while others (more 
> generic) work.
> 
> IMO, it should be acceptable to remove the need for the quirk in the 
> general case. On the small amount of cases where we actually need to 
> read the current values, the driver in charge (hid-mt or wacom) already 
> retrieves the features manually.

Applied to for-4.12/nuke-no-init-reports-quirk. Thanks,

-- 
Jiri Kosina
SUSE Labs

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
