From: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] hid: sensor: fix input and feature attributes in HID
 sensor custom sysfs interface
Date: Fri, 4 Nov 2016 15:03:08 +0100
Message-ID: <20161104140308.GC20334@mail.corp.redhat.com>
References: <1478170515-24436-1-git-send-email-joyce.ooi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1478170515-24436-1-git-send-email-joyce.ooi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Ooi, Joyce" <joyce.ooi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kweh Hock Leong <hock.leong.kweh-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ong Boon Leong <boon.leong.ong-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lay Kuan Loon <kuan.loon.lay-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Nov 03 2016 or thereabouts, Ooi, Joyce wrote:
> User is unable to access to input-X-yyy and feature-X-yyy where
> X is a hex value and more than 9 (e.g. input-a-yyy, feature-b-yyy) in HID
> sensor custom sysfs interface.
> This is because when creating the attribute, the attribute index is
> written to using %x (hex). However, when reading and writing values into
> the attribute, the attribute index is scanned using %d (decimal). Hence,
> user is unable to access to attributes with index in hex values
> (e.g. 'a', 'b', 'c') but able to access to attributes with index in
> decimal values (e.g. 1, 2, 3,..).
> This fix will change input-%d-%x-%s and feature-%d-%x-%s to input-%x-%x-%s
> and feature-%x-%x-%s in show_values() and store_values() accordingly.
> 
> Signed-off-by: Ooi, Joyce <joyce.ooi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Reviewed-by: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
