From: Vladis Dronov <vdronov@redhat.com>
Subject: Re: [PATCH] Input: aiptek: fix crash on detecting device without
 endpoints
Date: Mon, 30 Nov 2015 07:36:47 -0500 (EST)
Message-ID: <689469584.28015553.1448887007112.JavaMail.zimbra@redhat.com>
References: <Pine.LNX.4.44L0.1511271650030.17118-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_28015551_1876869505.1448887007108"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:43973 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753467AbbK3Mg4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Nov 2015 07:36:56 -0500
In-Reply-To: <Pine.LNX.4.44L0.1511271650030.17118-100000@netrider.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

------=_Part_28015551_1876869505.1448887007108
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hello, Alan, all.

> > > > Hmm, I see quite a few drivers assuming that endpoint 0 will be present.
> > > > I wonder if that should not be solved at USB level.
> > >
> > > Every USB device always has endpoint 0.  If one didn't, the kernel 
> > > wouldn't be able to initialize and enumerate it.
> > 
> > Yes for the normal USB device. This case is a weird USB device (with no
> > endpoints) specially designed to be weird. My point here is that even a
> > weird device probing should not crash a kernel by a NULL-deref.
> 
> True.  However, a weird device that didn't have any endpoint 0 would
> not crash the kernel, because the kernel wouldn't be able to
> communicate with it at all.

I'm afraid, I do not get you here. A device in question _does_ crash the kernel
(or driver only) as this call trace shows (see attached for the full call trace),
and that's why the patch is proposed:

[  622.444650] BUG: unable to handle kernel NULL pointer dereference at 0000000000000002
[  622.445019] IP: [<ffffffffa0395303>] aiptek_probe+0x463/0x658 [aiptek]
[  622.445019] RIP: 0010:[<ffffffffa0395303>] aiptek_probe+0x463/0x658 [aiptek]
[  622.445019] RAX: 0000000000000000 RBX: ffff88000bd67800 RCX: ffff88000bcd0800
                        ^^^ rax is NULL, it is being dereferenced

Kernel does not communicates with the device, but the driver tries to access
a kernel structure, which was not allocated (thus, a null-deref):

endpoint = &intf->altsetting[0].endpoint[0].desc; // the structure endpoint[0]
                                             // was not kzalloc()ed, thus NULL
usb_rcvintpipe(aiptek->usbdev, endpoint->bEndpointAddress) // NULL deref

> > > > Alan, does it make sense to have drivers probe interface if it does not
> > > > have any endpoints?
> > >
> > > Yes; in theory an interface can do everything it needs using only 
> > > endpoint 0.  Driver shouldn't assume anything about the endpoints in 
> > > the interfaces they problem.
> > 
> > The current kernel code in drivers/usb/core/config.c accepts an interface
> > with no endpoints in one of its configurations, and I could not find a
> > direct ban for that in USB standard. So, I currently believe, it is a driver
> > job to check if the endpoint 0 exist, otherwise we must change the kernel
> > USB detection code.
> 
> Drivers do not have to check whether endpoint 0 exists; it always does.  
> But they do have to check any other endpoint they use.

As the above example shows, endpoint 0 does not always exists. A specially
crafted weird USB device can advertise absence of endpoint 0 and the kernel
will accept this:

[drivers/usb/core/config.c]
num_ep = num_ep_orig = alt->desc.bNumEndpoints;  // weird device can have 0 here
alt->desc.bNumEndpoints = 0;
if (num_ep > 0) {
        /* Can't allocate 0 bytes */
        len = sizeof(struct usb_host_endpoint) * num_ep;
        alt->endpoint = kzalloc(len, GFP_KERNEL);

As far as I understand, this is a question we discuss here: whose responsibility
is to handle situations of endpoint 0 absence in an altconfig?

- if it is driver's job, a driver much check this, as in the patch I propose

- if it is a kernel job not to allow devices with no endpoint 0 in one the
configurations, the current USB device detection implementation (in
drivers/usb/core/config.c) should be modified, as currently it allows such.

I do not have much expertise in the Linux USB stack, so I'm asking you and
the community for an advise on this.

> > btw, indeed, this is not the only driver with this problem, I've met 2 more.
> 
> In fact, there's no way to check whether endpoint 0 exists.  Where 
> would you look to find out?  There isn't any endpoint descriptor for it.

I believe, there is a configuration descriptor for that, probably, I'm wrong:

if (intf->altsetting[0].desc.bNumEndpoints < 1) { ...

Best regards,
Vladis Dronov | Red Hat, Inc. | Product Security Engineer
------=_Part_28015551_1876869505.1448887007108
Content-Type: text/plain; name=stacktrace.txt
Content-Disposition: attachment; filename=stacktrace.txt
Content-Transfer-Encoding: base64

WyAgNjIyLjE0OTk1N10gdXNiIDEtMTogbmV3IGZ1bGwtc3BlZWQgVVNCIGRldmljZSBudW1iZXIg
MiB1c2luZyB4aGNpX2hjZApbICA2MjIuMzU0NDg1XSB1c2IgMS0xOiBjb25maWcgMSBpbnRlcmZh
Y2UgMCBhbHRzZXR0aW5nIDAgaGFzIDMgZW5kcG9pbnQgZGVzY3JpcHRvcnMsIGRpZmZlcmVudCBm
cm9tIHRoZSBpbnRlcmZhY2UgZGVzY3JpcHRvcidzIHZhbHVlOiAwClsgIDYyMi4zODY2MzBdIHVz
YiAxLTE6IE5ldyBVU0IgZGV2aWNlIGZvdW5kLCBpZFZlbmRvcj0wNDU4LCBpZFByb2R1Y3Q9NTAw
MwpbICA2MjIuMzkyNDE0XSB1c2IgMS0xOiBOZXcgVVNCIGRldmljZSBzdHJpbmdzOiBNZnI9MSwg
UHJvZHVjdD0yLCBTZXJpYWxOdW1iZXI9MwpbICA2MjIuMzk5NDE2XSB1c2IgMS0xOiBQcm9kdWN0
OiDEiQpbICA2MjIuNDA0NjQwXSB1c2IgMS0xOiBNYW51ZmFjdHVyZXI6IMSJClsgIDYyMi40MTAw
NzldIHVzYiAxLTE6IFNlcmlhbE51bWJlcjogJQpbICA2MjIuNDQ0NjUwXSBCVUc6IHVuYWJsZSB0
byBoYW5kbGUga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBhdCAwMDAwMDAwMDAwMDAw
MDAyClsgIDYyMi40NDUwMTldIElQOiBbPGZmZmZmZmZmYTAzOTUzMDM+XSBhaXB0ZWtfcHJvYmUr
MHg0NjMvMHg2NTggW2FpcHRla10KWyAgNjIyLjQ0NTAxOV0gUEdEIDAgClsgIDYyMi40NDUwMTld
IE9vcHM6IDAwMDAgWyMxXSBTTVAgClsgIDYyMi40NDUwMTldIE1vZHVsZXMgbGlua2VkIGluOiBh
aXB0ZWsoKykgaXA2dF9ycGZpbHRlciBpcDZ0X1JFSkVDVCBpcHRfUkVKRUNUIHh0X2Nvbm50cmFj
ayBlYnRhYmxlX25hdCBlYnRhYmxlX2Jyb3V0ZSBicmlkZ2Ugc3RwIGxsYyBlYnRhYmxlX2ZpbHRl
ciBlYnRhYmxlcyBpcDZ0YWJsZV9uYXQgbmZfY29ubnRyYWNrX2lwdjYgbmZfZGVmcmFnX2lwdjYg
bmZfbmF0X2lwdjYgaXA2dGFibGVfbWFuZ2xlIGlwNnRhYmxlX3NlY3VyaXR5IGlwNnRhYmxlX3Jh
dyBpcDZ0YWJsZV9maWx0ZXIgaXA2X3RhYmxlcyBpcHRhYmxlX25hdCBuZl9jb25udHJhY2tfaXB2
NCBuZl9kZWZyYWdfaXB2NCBuZl9uYXRfaXB2NCBuZl9uYXQgbmZfY29ubnRyYWNrIGlwdGFibGVf
bWFuZ2xlIGlwdGFibGVfc2VjdXJpdHkgaXB0YWJsZV9yYXcgaXB0YWJsZV9maWx0ZXIgaXBfdGFi
bGVzIGJvY2hzX2RybSBwcGRldiBzeXNjb3B5YXJlYSBzeXNmaWxscmVjdCBzeXNpbWdibHQgdHRt
IGRybV9rbXNfaGVscGVyIGRybSBwY3Nwa3IgaTJjX3BpaXg0IGkyY19jb3JlIHNlcmlvX3JhdyBw
YXJwb3J0X3BjIHBhcnBvcnQgeGZzIGxpYmNyYzMyYyBzZF9tb2Qgc3JfbW9kIGNyY190MTBkaWYg
Y2Ryb20gY3JjdDEwZGlmX2NvbW1vbiBhdGFfZ2VuZXJpYyBwYXRhX2FjcGkgYXRhX3BpaXggbGli
YXRhIGUxMDAwIGZsb3BweSBkbV9taXJyb3IgZG1fcmVnaW9uX2hhc2ggZG1fbG9nIGRtX21vZApb
ICA2MjIuNDQ1MDE5XSBDUFU6IDAgUElEOiAyMjQyIENvbW06IHN5c3RlbWQtdWRldmQgTm90IHRh
aW50ZWQgMy4xMC4wLTIyOS4xNC4xLmVsNy54ODZfNjQgIzEKWyAgNjIyLjQ0NTAxOV0gSGFyZHdh
cmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5NiksIEJJT1MgcmVs
LTEuOC4yLTAtZzMzZmJlMTMgYnkgcWVtdS1wcm9qZWN0Lm9yZyAwNC8wMS8yMDE0ClsgIDYyMi40
NDUwMTldIHRhc2s6IGZmZmY4ODAwMGU2NWEyMjAgdGk6IGZmZmY4ODAwMGY0Y2MwMDAgdGFzay50
aTogZmZmZjg4MDAwZjRjYzAwMApbICA2MjIuNDQ1MDE5XSBSSVA6IDAwMTA6WzxmZmZmZmZmZmEw
Mzk1MzAzPl0gIFs8ZmZmZmZmZmZhMDM5NTMwMz5dIGFpcHRla19wcm9iZSsweDQ2My8weDY1OCBb
YWlwdGVrXQpbICA2MjIuNDQ1MDE5XSBSU1A6IDAwMTg6ZmZmZjg4MDAwZjRjZmI4MCAgRUZMQUdT
OiAwMDAxMDI4NgpbICA2MjIuNDQ1MDE5XSBSQVg6IDAwMDAwMDAwMDAwMDAwMDAgUkJYOiBmZmZm
ODgwMDBiZDY3ODAwIFJDWDogZmZmZjg4MDAwYmNkMDgwMApbICA2MjIuNDQ1MDE5XSBSRFg6IDAw
MDAwMDAwMDAwMDAwMDAgUlNJOiAwMDAwMDAwMDAwMDAwMDA4IFJESTogZmZmZjg4MDAwY2EyOTAw
MApbICA2MjIuNDQ1MDE5XSBSQlA6IGZmZmY4ODAwMGY0Y2ZiZTAgUjA4OiAwMDAwMDAwMDAwMDAw
MDAwIFIwOTogMDAwMDAwMDAwMDAwMDAwMApbICA2MjIuNDQ1MDE5XSBSMTA6IGZmZmY4ODAwMGU0
MDE0MDAgUjExOiBmZmZmZmZmZjgxMDAyMGQ4IFIxMjogZmZmZjg4MDAwYzUyNTgwMApbICA2MjIu
NDQ1MDE5XSBSMTM6IGZmZmY4ODAwMGM1MjU4MzAgUjE0OiBmZmZmODgwMDBiY2QxODAwIFIxNTog
ZmZmZjg4MDAwYmQ2NzgzNApbICA2MjIuNDQ1MDE5XSBGUzogIDAwMDA3ZmI4MDgyYjQ4ODAoMDAw
MCkgR1M6ZmZmZjg4MDAwZmMwMDAwMCgwMDAwKSBrbmxHUzowMDAwMDAwMDAwMDAwMDAwClsgIDYy
Mi40NDUwMTldIENTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAw
M2IKWyAgNjIyLjQ0NTAxOV0gQ1IyOiAwMDAwMDAwMDAwMDAwMDAyIENSMzogMDAwMDAwMDAwZDY3
ZjAwMCBDUjQ6IDAwMDAwMDAwMDAwMDA2ZjAKWyAgNjIyLjQ0NTAxOV0gRFIwOiAwMDAwMDAwMDAw
MDAwMDAwIERSMTogMDAwMDAwMDAwMDAwMDAwMCBEUjI6IDAwMDAwMDAwMDAwMDAwMDAKWyAgNjIy
LjQ0NTAxOV0gRFIzOiAwMDAwMDAwMDAwMDAwMDAwIERSNjogMDAwMDAwMDBmZmZmMGZmMCBEUjc6
IDAwMDAwMDAwMDAwMDA0MDAKWyAgNjIyLjQ0NTAxOV0gU3RhY2s6ClsgIDYyMi40NDUwMTldICBm
ZmZmODgwMDBiY2QwODAwIDAwMDAwMDAwMDAwMDAwMDEgMDAwMDAxOTAwMDAwMDI0NiAwMDAwMDE5
MDAwMDAwMDMyClsgIDYyMi40NDUwMTldICAwMDAwMDA2NDAwMDAwMDE5IDAwMDAwMTJjMDAwMDAw
YzggMDAwMDAwMDAwY2MzZTA5MiBmZmZmODgwMDBiY2QwODkwClsgIDYyMi40NDUwMTldICBmZmZm
ODgwMDBiY2QwODAwIGZmZmZmZmZmYTAzOTcwNjggZmZmZjg4MDAwYzUyNTgzMCBmZmZmZmZmZmEw
Mzk2NWMwClsgIDYyMi40NDUwMTldIENhbGwgVHJhY2U6ClsgIDYyMi40NDUwMTldICBbPGZmZmZm
ZmZmODE0MWRjMDQ+XSB1c2JfcHJvYmVfaW50ZXJmYWNlKzB4MWM0LzB4MmYwClsgIDYyMi40NDUw
MTldICBbPGZmZmZmZmZmODEzZDMwZDc+XSBkcml2ZXJfcHJvYmVfZGV2aWNlKzB4ODcvMHgzOTAK
WyAgNjIyLjQ0NTAxOV0gIFs8ZmZmZmZmZmY4MTNkMzRiMz5dIF9fZHJpdmVyX2F0dGFjaCsweDkz
LzB4YTAKWyAgNjIyLjQ0NTAxOV0gIFs8ZmZmZmZmZmY4MTNkMzQyMD5dID8gX19kZXZpY2VfYXR0
YWNoKzB4NDAvMHg0MApbICA2MjIuNDQ1MDE5XSAgWzxmZmZmZmZmZjgxM2QwZTQzPl0gYnVzX2Zv
cl9lYWNoX2RldisweDczLzB4YzAKWyAgNjIyLjQ0NTAxOV0gIFs8ZmZmZmZmZmY4MTNkMmIyZT5d
IGRyaXZlcl9hdHRhY2grMHgxZS8weDIwClsgIDYyMi40NDUwMTldICBbPGZmZmZmZmZmODEzZDI2
ODA+XSBidXNfYWRkX2RyaXZlcisweDIwMC8weDJkMApbICA2MjIuNDQ1MDE5XSAgWzxmZmZmZmZm
ZjgxM2QzYjM0Pl0gZHJpdmVyX3JlZ2lzdGVyKzB4NjQvMHhmMApbICA2MjIuNDQ1MDE5XSAgWzxm
ZmZmZmZmZjgxNDFjMWMyPl0gdXNiX3JlZ2lzdGVyX2RyaXZlcisweDgyLzB4MTYwClsgIDYyMi40
NDUwMTldICBbPGZmZmZmZmZmYTAzOWEwMDA+XSA/IDB4ZmZmZmZmZmZhMDM5OWZmZgpbICA2MjIu
NDQ1MDE5XSAgWzxmZmZmZmZmZmEwMzlhMDFlPl0gYWlwdGVrX2RyaXZlcl9pbml0KzB4MWUvMHgx
MDAwIFthaXB0ZWtdClsgIDYyMi40NDUwMTldICBbPGZmZmZmZmZmODEwMDIwZTg+XSBkb19vbmVf
aW5pdGNhbGwrMHhiOC8weDIzMApbICA2MjIuNDQ1MDE5XSAgWzxmZmZmZmZmZjgxMGRkMGVlPl0g
bG9hZF9tb2R1bGUrMHgxMzNlLzB4MWI0MApbICA2MjIuNDQ1MDE5XSAgWzxmZmZmZmZmZjgxMmY3
ZDYwPl0gPyBkZGVidWdfcHJvY193cml0ZSsweGYwLzB4ZjAKWyAgNjIyLjQ0NTAxOV0gIFs8ZmZm
ZmZmZmY4MTBkOTZiMz5dID8gY29weV9tb2R1bGVfZnJvbV9mZC5pc3JhLjQyKzB4NTMvMHgxNTAK
WyAgNjIyLjQ0NTAxOV0gIFs8ZmZmZmZmZmY4MTBkZGFhNj5dIFN5U19maW5pdF9tb2R1bGUrMHhh
Ni8weGQwClsgIDYyMi40NDUwMTldICBbPGZmZmZmZmZmODE2MTQzODk+XSBzeXN0ZW1fY2FsbF9m
YXN0cGF0aCsweDE2LzB4MWIKWyAgNjIyLjQ0NTAxOV0gQ29kZTogNDUgMzEgYzkgNDUgMzEgYzAg
YjkgZmYgMDMgMDAgMDAgYmUgMDggMDAgMDAgMDAgNGMgODkgZjcgZTggOTAgMzkgMGQgZTEgNDkg
OGIgMDQgMjQgNDggOGIgNGIgMDggNDggOGIgYmIgMTAgMDEgMDAgMDAgNDggOGIgNDAgMTggPDBm
PiBiNiA1MCAwMiAwZiBiNiA3MCAwNiA4YiAwMSBjMSBlMiAwZiBjMSBlMCAwOCA4MSBjYSA4MCAw
MCAwMCAKWyAgNjIyLjQ0NTAxOV0gUklQICBbPGZmZmZmZmZmYTAzOTUzMDM+XSBhaXB0ZWtfcHJv
YmUrMHg0NjMvMHg2NTggW2FpcHRla10KWyAgNjIyLjQ0NTAxOV0gIFJTUCA8ZmZmZjg4MDAwZjRj
ZmI4MD4KWyAgNjIyLjQ0NTAxOV0gQ1IyOiAwMDAwMDAwMDAwMDAwMDAyClsgIDYyMi44NjA3NzJd
IC0tLVsgZW5kIHRyYWNlIGIyMzk2NjMzNTRhMWM1NTYgXS0tLQpbICA2MjIuODY0ODEzXSBLZXJu
ZWwgcGFuaWMgLSBub3Qgc3luY2luZzogRmF0YWwgZXhjZXB0aW9uClsgIDYyMi44NjU3NjhdIGRy
bV9rbXNfaGVscGVyOiBwYW5pYyBvY2N1cnJlZCwgc3dpdGNoaW5nIGJhY2sgdG8gdGV4dCBjb25z
b2xlCg==
------=_Part_28015551_1876869505.1448887007108--
