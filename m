From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH 1/7] Input: ALPS - Move protocol information to
 Documentation
Date: Mon, 31 Oct 2011 14:15:26 -0400
Message-ID: <20111031181525.GA12205@thinkpad-t410>
References: <1319663681-11244-1-git-send-email-seth.forshee@canonical.com>
 <1319663681-11244-2-git-send-email-seth.forshee@canonical.com>
 <4EAD6E36.4070502@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4EAD6E36.4070502@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alessandro Rubini <rubini@cvml.unipv.it>, Henrik Rydberg <rydberg@euromail.se>, Andrew Skalski <askalski@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, Oct 30, 2011 at 11:33:10AM -0400, Chase Douglas wrote:
> On 10/26/2011 05:14 PM, Seth Forshee wrote:
> > In preparation for new protocol support, move the protocol
> > information currently documented in alps.c to
> > Documentation/input/alps.txt, where it can be expanded without
> > cluttering up the driver.
> > 
> > Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> 
> Makes sense. Only question is whether we should create a subdir for
> device protocols (Documentation/input/devices/alps.txt)?

That's probably a good idea if protocol documentation is going to
proliferate, but currently these docs are in Documentation/input. If we
want to move them it's a subject for a separate patch.
