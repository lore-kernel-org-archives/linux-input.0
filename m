From: Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: [PATCH v2] Input - mt: Fix input_mt_get_slot_by_key
Date: Thu, 23 Apr 2015 20:52:27 +0200
Message-ID: <55393F6B.8050904@bitmath.org>
References: <1427741655-4142-1-git-send-email-benjamin.tissoires@redhat.com> <20150406163349.GD36770@dtor-ws> <alpine.LNX.2.00.1504071517260.30181@pobox.suse.cz> <CAKdAkRROn=tCuSDmCqsugPAFBsTa5jEZsOEoTBCAFUrheM2X8Q@mail.gmail.com> <5539279F.4050400@bitmath.org> <20150423182046.GF34808@dtor-ws> <20150423183827.GA10937@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150423183827.GA10937@mail.corp.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: Jiri Kosina <jkosina@suse.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

> My guess is that none of these drivers are
> able to handle a silent closing of a slot and the easiest solution might
> be to simply change the documentation if in fact nobody uses the
> compressed notation (which removes just one ABS_SLOT event within the
> frame, so not sure we can call it compressed BTW).

No, this is a very bad idea. As is obvious from the patch and the problem, there
are cases that the typical add/remove interface cannot handle, without either
adding more frames or support twice as many slots. How else would you report a
complete change of all N contacts into N new contacts, for instance?

The kernel protocol is solid and works for all cases. Userland thus has access
to a complete solution.

Henrik
