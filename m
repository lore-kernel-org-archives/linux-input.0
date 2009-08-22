From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: haptics devices linux driver support
Date: Sat, 22 Aug 2009 19:21:08 +0200
Message-ID: <4A902904.2090008@gmail.com>
References: <5d5443650908221004y5b893382m368dc18a38636c1b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933021AbZHVRVN@vger.kernel.org>
In-Reply-To: <5d5443650908221004y5b893382m368dc18a38636c1b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 08/22/2009 07:04 PM, Trilok Soni wrote:
> Does anyone know example Linux drivers for haptics devices?

Yup, drivers/misc/phantom.c for Sensable Phantom (the old one over PCI).
The rest needed (esp. floating point computation) is done in userspace.

Then, all force-feedack drivers under drivers/input and drivers/hid.

What exactly do you want to know?
