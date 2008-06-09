From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 06/10] HID: move logitech report quirks
Date: Mon, 09 Jun 2008 12:29:50 +0200
Message-ID: <484D061E.5000308@gmail.com>
References: <1210931362-18422-1-git-send-email-jirislaby@gmail.com> <1210931362-18422-2-git-send-email-jirislaby@gmail.com> <1210931362-18422-3-git-send-email-jirislaby@gmail.com> <1210931362-18422-4-git-send-email-jirislaby@gmail.com> <1210931362-18422-5-git-send-email-jirislaby@gmail.com> <1210931362-18422-6-git-send-email-jirislaby@gmail.com> <Pine.LNX.4.64.0806041415130.10085@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759984AbYFIKbN@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0806041415130.10085@jikos.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, marcel@holtmann.org, linux-kernel@vger.kernel.org, anssi.hannula@gmail.com
List-Id: linux-input@vger.kernel.org

Hi!

On 06/04/2008 02:16 PM, Jiri Kosina wrote:
> On Fri, 16 May 2008, Jiri Slaby wrote:
>> Move them from core code to a separate driver.
> is there a reason why this moves only the report descriptor 
> Logitech-specific quirks, but leaves the input mapping still in 
> hid-input-quirks.c and doesn't move it into ->input_mapping method too?

No, there is no strong reason, I just postponed it to the second round of 
changes. I wanted to hear comments first, so I only moved fully only apple 
driver (to present how the concept was thought). After things settle down, I'm 
going to move the rest of quirks including this one.
