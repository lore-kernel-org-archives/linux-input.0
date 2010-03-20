From: Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: input: mt: Software finger tracking in the kernel?
Date: Sat, 20 Mar 2010 23:31:45 +0100
Message-ID: <4BA54CD1.6060706@bitmath.org>
References: <4BA358DB.20708@enmesh.se> <20100320194424.GC28402@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100320194424.GC28402@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@enmesh.se>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> [...] I'd envisioned something more like a library providing common
> code that drivers could opt in to use, like we hane ff-memless for
> memory-less force-feedback devices.

As long as one can queue work with such a method, it looks like a good idea.

Henrik
