From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH 2/4] HID: fix appletouch regression
Date: Wed, 22 Oct 2008 15:03:08 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0810221502440.27479@jikos.suse.cz>
References: <1224624363-16471-1-git-send-email-jirislaby@gmail.com> <1224624363-16471-2-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1224624363-16471-2-git-send-email-jirislaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Slaby <jirislaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Steven Noonan <steven-Cunn4gMjHvbm+q05EWxUEA@public.gmane.org>, Justin Mattock <justinmattock-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sven Anders <anders-3bOZC6EutKuELgA04lAiVw@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, 21 Oct 2008, Jiri Slaby wrote:

> The appletouch mouse devices are grabbed by the hid bus and not
> released even if apple driver says ENODEV (as expected).
> Move the ignoration one level upper to deny the hid layer to grab
> the device and return error to the usb hid which, as a result,
> releases the device.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
