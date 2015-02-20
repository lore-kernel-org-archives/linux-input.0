From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 6/7] thinkpad_acpi: More Carbon X1 2014 keys
Date: Fri, 20 Feb 2015 11:27:39 -0800
Message-ID: <54E78AAB.2020604@mit.edu>
References: <1424443477.22910.18.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1424443477.22910.18.camel@hadess.net>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Darren Hart <dvhart@infradead.org>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org

On 02/20/2015 06:44 AM, Bastien Nocera wrote:
> +		KEY_MICCANCEL_MODE,  /* Microphone cancellation */

What's this?  We already have KEY_MICMUTE.  Is this different?  If so, 
can you improve the comment a bit?

The answer may be obvious to anyone who has an awful X1 carbon gen 2 
keyboard, but these KEY_XYZ defines should IMO be clear enough that even 
people without the hardware can figure out what's going on.

--Andy
