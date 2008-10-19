From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: several messages
Date: Mon, 20 Oct 2008 00:09:22 +0200
Message-ID: <48FBB012.40605@gmail.com>
References: <1224425749-22652-1-git-send-email-jirislaby@gmail.com> <1224425749-22652-2-git-send-email-jirislaby@gmail.com> <alpine.LNX.1.10.0810192135010.27479@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752370AbYJSWJk@vger.kernel.org>
In-Reply-To: <alpine.LNX.1.10.0810192135010.27479@jikos.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Steven Noonan <steven@uplinklabs.net>, Justin Mattock <justinmattock@gmail.com>, Sven Anders <anders@anduras.de>, Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Jiri Kosina napsal(a):
> On Sun, 19 Oct 2008, Jiri Slaby wrote:
> 
>> +enum hid_type {
>> +	HID_TYPE_UNKNOWN = 0,
>> +	HID_TYPE_MOUSE,
>> +	HID_TYPE_KEYBOARD
>> +};
>> +
> 
> Do we really need the HID_TYPE_KEYBOARD at all? It's not used anywhere in 
> the code. I'd propose to add it when it is actually needed. I.e. have the 
> enum contain something like HID_TYPE_MOUSE HID_TYPE_OTHER for now, and add 
> whatever will become necessary in the future, what do you think?

I would use unknown rather than other, since on bluetooth mouse is unknown
not other, if you don't mind?

Or did you mean tristate unknown, mouse and other?

Thanks for review.
