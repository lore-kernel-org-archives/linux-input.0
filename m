From: Stephan Mueller <smueller@chronox.de>
Subject: Re: Sony Vaio Duo 11: getting middle mouse button to work
Date: Fri, 31 Jan 2014 05:31:53 +0100
Message-ID: <13914184.mVhhUrzN60@myon.chronox.de>
References: <1674012.xCMptsh8XR@myon.chronox.de> <2193004.SWLhWZ2AvA@tauon> <CAN+gG=HAXE4LT_tN+3tE8-T_L5g+2HAE35CN+z8KCEQcmJ=JWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart3762602.0SCRtIrO20"
Content-Transfer-Encoding: 7Bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <CAN+gG=HAXE4LT_tN+3tE8-T_L5g+2HAE35CN+z8KCEQcmJ=JWw@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Mattia Dongili <malattia@linux.it>, platform-driver-x86@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart3762602.0SCRtIrO20
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Donnerstag, 30. Januar 2014, 22:50:25 schrieb Benjamin Tissoires:

Hi Benjamin,

> > Can you please help me how to do that? I install Windows in a KVM with
> > the mouse device as a USB-passthrough device -- shall I detach the Linux
> > USB driver?
> 
> No, you don't have to detach the Linux USB driver (it's done for you
> by KVM IIRC).

Correct, libvirtd is the one that detaches the driver when I start the VM.
> 
> > Now, shall I use hid-recorder on that device or rather usbmon while
> > Windows is booting?
> 
> usbmon is the tool you need. hid-recorder will not work because the
> hid subsystem will be disconnected as the device is used by Windows.
> 
> You can even use wireshark now. It gives you a nice interface and
> interpretation of the USB packets :)

Please see attached for the USB sniffing on the USB bus with the Crucialtec 
touch pad when Windows starts up and shuts down. To drive the device, Windows 
uses the Crucialtec driver according to its device settings display.

The attached log contains the log information for the mouse (device 001:005) 
and the USB bridge (device 001:002). I cut out the listing for the touch pad 
which is also attached to that bridge.

The strange thing, however, is the following: the mouse works in Windows when 
I do not sniff on the USB bus using usbmon. But as soon as I start sniffing, 
it does not work any more.

Is that log helpful?

Ciao
Stephan
-- 
| Cui bono? |
--nextPart3762602.0SCRtIrO20
Content-Disposition: attachment; filename="sony-vaio-duo-11-usbsniff.bz2"
Content-Transfer-Encoding: base64
Content-Type: application/x-bzip; name="sony-vaio-duo-11-usbsniff.bz2"

QlpoOTFBWSZTWcP3RjEADf7fgEgQQAJ/9gggCAA/IIgAYAf8PhzSYBWhVKUgNaVmAUAAAAAEiBNT
UTUmQNAFAAAAABJpFEBRoDQNqFAAAAAAqRBAgqekIaZHBAD+kkIwD6sfal1nlrj3eM98rrjuhRFN
ZWNcxbiuPLrtKwWayrylHKWukM1daqqPlquNUVZbVa0VQCdflJ6AdiILBD264itpfk/5zIncTX7u
aWjMexzJqR0saKRulb0fofziS5NxeTDJSnTK1P4iiNtZwYXJSfXvWmpUiKFSBfBcPhhxFjTL7GWz
CfJKR1FRKVOEj0QYYfOJp8Y8jtF3TJXJRx1y5FhdEhDVgcJf1s3lTMbjqad7m8r6dyVl5Gbsa5vO
Nxt6bzlPc/YyMiEEIIiAgJBSGmhrvWPFG9307vzOcnsxmwTzTIyJ3MrkbkxDuYv1S9pSiwEv3SGk
IGA2CbILIqyP6oQQCWEhgQQw8AU/iQSUhpMMIIS0UiUwKJKFCOxSUFGJSXHTvx63+pO4JySHNFSc
+nVllSnNVzGsSVMqPxs+OSnslMlfww/Z46eOFOUQw1SuS52hFRUkqFEnh5HxiYj2L5kkoVCiwWiX
KTEYSCjfC01R4y3GClJV/S5KSoXJZpMMVKpLjUdsRwt3obmovkYkuTEXFRpwWc0bWRlpgxypJ6Kg
3VDUcKTe3JNtmJLQho4BDYMmcOFgkYeTkZp2MOZDGXGzjMywpRa2mIuRCpIo4pGqDrQe4mQTjg2k
jnUbnPOWU1yYOyKg65MsM4ZVJp9jtuNUk1FRK8ScE/tOI26OCfEVJuPsXDlTLJcOm+PHHy9+ucq5
vI8e3RiDeFXJ0zLJpUYcTnjMZT+lr8dYOJpKCzFkk2pEW8J8+IfvngMO1w4DCX7FF02eNS+xhYI6
+66005hnlqZd8MysFcddhrXxJEoNDAISQ2krCwhFTJzYh3r5NSBA2p2XHEniiTb4bt6qVfphoKqF
J1y/EXHZrnbOC0XpZs9s785dyZ44k1qE+eJIL2DBBECwciOMSw20veeFIxTHHXWMOu3a+AfXaT4n
yTJHod13Xr3Vayo9lBqSnjeUwo7pTVjznBxRqkkR6ez489gX4dI5J6mPLw8mi9MhvwAgox10cJPv
RwypVVQ67nBdlUllSvGfPMt48hlLO0bnVRy2tucWs6pMVkrUCTPU+p5UZUxJJsXVvA6UVTL5HosO
mjGnnbH5vlV5HTpw0gw0JkzXPAjma74PnA6FFiph4j4Hm+FWgyH5JcwXqT0O9dLLZXkLywEDEwRH
yCOGHrmwqfTMuOWEIx1RFQeyJU+7plU2WfcESZ7bKXalsrZiGHEq8PSPUjDZibbKJgy3Jufc6RzN
nnDRYUMYIaPbmJJ7B66RPN3u3oc9+h29iToHYRGPezw08GDOzqKuNhMQNoC/KjadXeRjI+wj86Jn
4Chinq+nRUZ4yvzzXMcEf2mD9LFG0nVEe6CQRH2MgS4fFA0Wi8IoPc/pTcq2ZMzbl5YQTphNKvuE
Bxr68/IkhfgudJTYKRcKP3oWPZ3z7/Pfzi8bt46n0w4cSNKS+bBt1k5aKunmzT5U2ibySfQRVChA
Vwut6TaaG9UTmhbQoMIgjGjBECgMKqSWTgkhKVkX0ehEQGShSKRUhSKSS9ZbYMV1EkHxiRUdR0yy
VJX1wfCvSM8KSfyNJP2OkmWNKLR+lJ7JlcemzLlJadjCeo/JHST3IcwdKIk5T8YPCM8yeNwYSRK1
FWkif4kif0h/5QikUI4gn/xdyRThQkMP3RjE

--nextPart3762602.0SCRtIrO20--
