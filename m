From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: multitouch: support buttons and trackpoint on Lenovo
 X1 Tab Gen2
Date: Wed, 6 Sep 2017 11:00:05 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1709061059530.4077@jbgna.fhfr.qr>
References: <1503698764-172030-1-git-send-email-pasha.tatashin@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503698764-172030-1-git-send-email-pasha.tatashin@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: aduggan@synaptics.com, benjamin.tissoires@redhat.com, rydberg@bitmath.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 25 Aug 2017, Pavel Tatashin wrote:

> On the 2nd generation Lenovo Tablet only clickpad is working; the
> trackpoint and three mouse buttons do not work.
> 
> hid_multitouch must export all inputs in order to get trackpoint and
> buttons to function.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Applied to for-4.14/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs
