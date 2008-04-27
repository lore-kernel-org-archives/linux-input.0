From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: HID bus
Date: Sun, 27 Apr 2008 13:22:36 +0200
Message-ID: <481461FC.8000006@gmail.com>
References: <Pine.LNX.4.64.0804181333180.12972@jikos.suse.cz> <1208644696-29129-1-git-send-email-jirislaby@gmail.com> <480B2F9A.3020104@gmail.com> <Pine.LNX.4.64.0804220158560.12972@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760198AbYD0LWy@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0804220158560.12972@jikos.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, marcel@holtmann.org, mit-devel@lists.printk.net, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 04/22/2008 02:00 AM, Jiri Kosina wrote:
> On Sun, 20 Apr 2008, Jiri Slaby wrote:
> 
>> So I suppose we still need the option to let users compile all the 
>> chosen drivers into hid.
> 
> Another possible workaround is to introduce dummy "hid" module, that will 
> just depend on all other drivers with a reference to certail symbol (and 
> this could of course be optional as CONFIG_HID_COMPAT, or whatever).

If I understand correctly, it would create circular dependency:
hid->dummy_hid->hid_apple->hid

Is is correct?

Thanks.
