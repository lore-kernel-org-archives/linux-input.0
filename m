From: Jiri Kosina <jikos@kernel.org>
Subject: Re: Strange regression in hid_llogitech_dj (was: Re: Linux
 5.2-rc4)
Date: Wed, 12 Jun 2019 10:31:45 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1906121029350.27227@cbobk.fhfr.pm>
References: <CAHk-=wjm7FQxdF=RKa8Xe23CLNNpbGDOACewgo8e-hwDJ8TyQg@mail.gmail.com> <2268131.Lc39eCoc3j@kreacher> <nycvar.YFH.7.76.1906112358580.27227@cbobk.fhfr.pm> <1875376.0DUQQ8o03D@kreacher>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1875376.0DUQQ8o03D@kreacher>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Hans de Goede <hdegoede@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 12 Jun 2019, Rafael J. Wysocki wrote:

> It kind of helps, but there is a catch.
> 
> hid-logitech-dj is not loaded after a fresh boot, so I need to modprobe it manually and that
> appears to be blocking (apparently indefinitely) until terminated with ^C.  But then it turns
> out that hid-logitech-dj is there in the list of modules and it is in use (by usbhid) and the
> mouse works.

My bad, I should've asked you to test with the complete 'for-5.2/fixes' 
branch which contains two reverts [1] [2] that should fix this issue as 
well.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/commit/?h=for-5.2/fixes&id=e0b7f9bc0246bc642d1de2ff3ff133730584c956
[2] https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/commit/?h=for-5.2/fixes&id=f9482dabfd1686987cc6044e06ae0e4c05915518

-- 
Jiri Kosina
SUSE Labs
