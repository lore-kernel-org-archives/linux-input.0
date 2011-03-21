From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v3 5/5] hid-multitouch: migrate 3M PCT touch screens to
 hid-multitouch
Date: Mon, 21 Mar 2011 10:05:33 +0100
Message-ID: <20110321090533.GE3784@polaris.bitmath.org>
References: <1300454876-5017-1-git-send-email-benjamin.tissoires@enac.fr>
 <1300454876-5017-6-git-send-email-benjamin.tissoires@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1300454876-5017-6-git-send-email-benjamin.tissoires@enac.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Benjamin,

On Fri, Mar 18, 2011 at 02:27:56PM +0100, Benjamin Tissoires wrote:
> This patch merges the hid-3m-pct driver into hid-multitouch.
> To keep devices working the same way they used to with hid-3m-pct,
> we need to add two signal/noise ratios for width and height.
> We also need to work on width/height to send proper
> ABS_MT_ORIENTATION flag.
>=20
> Importing 3M into hid-multitouch also solved the bug in which
> devices handling width and height in their report descriptors
> did not show ABS_MT_TOUCH_MAJOR and ABS_MT_TOUCH_MINOR.
>=20
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
> Reviewed-by: St=E9phane Chatty <chatty@enac.fr>
> ---

The patch _looks_ good, but I have problems getting this to work on a
3M2256. What devices were this one tested on so far?

Henrik
