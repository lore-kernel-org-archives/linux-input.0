From: Carlos Corbacho <cathectic@gmail.com>
Subject: Re: [PATCH] input: Add wireless and bluetooth keycodes
Date: Thu, 3 May 2007 13:18:59 +0100
Message-ID: <200705031318.59817.cathectic@gmail.com>
References: <200705031215.16971.cathectic@gmail.com> <d120d5000705030458m7909bc5enc2ff6621f542c7cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000705030458m7909bc5enc2ff6621f542c7cf@mail.gmail.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Dimitry,

On Thursday 03 May 2007 12:58:45 Dmitry Torokhov wrote:
> Already have them:
>
> #define KEY_BLUETOOTH           237
> #define KEY_WLAN                238

My bad.

> > Also, add keycodes for these
> > keys having a separate off state (This is true on some machines,
> > such as many Acer laptops).
>
> Not sure why this is needed.

On my laptop (this also affects other Acer's), the real problem is that there 
is no way to tell if the device is enabled or disabled[1], unless you're 
keeping track of this yourself (not always reliable). The only thing that 
always changes is the scancode for the button in question.

It would be nice to have a separate keycode to match to the different 
scancodes for on and off (then match these to the relevant calls), rather 
than say for instance, mapping both wireless scancodes to KEY_WLAN, then 
trying to keep track of the current state and then deciding on this whether 
to disable the device in question (and then potentially deciding wrong).

-Carlos

[1] The wireless/ bluetooth features on some Acer laptops are software 
enabled, by ACPI methods calling a Windows Management Instrumentation 
device - and to add insult to injury, the WMI interface provided doesn't give 
us any means to find out the current state of these features.
-- 
Uni: c.corbacho@cs.ucl.ac.uk
Home: cathectic@gmail.com
GPG Key ID: 0x23EE722D
