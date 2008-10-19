From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: several messages
Date: Sun, 19 Oct 2008 21:40:02 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0810192135010.27479@jikos.suse.cz>
References: <1224425749-22652-1-git-send-email-jirislaby@gmail.com> <1224425749-22652-2-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751721AbYJSTkT@vger.kernel.org>
In-Reply-To: <1224425749-22652-2-git-send-email-jirislaby@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Steven Noonan <steven@uplinklabs.net>, Justin Mattock <justinmattock@gmail.com>, Sven Anders <anders@anduras.de>, Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, 19 Oct 2008, Jiri Slaby wrote:

> +enum hid_type {
> +	HID_TYPE_UNKNOWN = 0,
> +	HID_TYPE_MOUSE,
> +	HID_TYPE_KEYBOARD
> +};
> +

Do we really need the HID_TYPE_KEYBOARD at all? It's not used anywhere in 
the code. I'd propose to add it when it is actually needed. I.e. have the 
enum contain something like HID_TYPE_MOUSE HID_TYPE_OTHER for now, and add 
whatever will become necessary in the future, what do you think?


On Sun, 19 Oct 2008, Jiri Slaby wrote:

> +/**
> + * hid_mouse_ignore_list - mouse devices which must not be held by the hid layer
> + */

I think a more descriptive comment would be appropriate here. It might not 
be obvious on the first sight why this needs to be done separately from 
the generic hid_blacklist. I.e. something like

/** 
 * There are composite devices for which we want to ignore only a certain
 * interface. This is a list of devices for which only the mouse interface 
 * will be ignored.
 */

maybe?

Thanks,

-- 
Jiri Kosina
SUSE Labs
