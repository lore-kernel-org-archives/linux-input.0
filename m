From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH v2 2/8] [media] Add signed 16-bit pixel format
Date: Fri, 27 May 2016 13:52:13 +0100
Message-ID: <82b68931-0da1-bd26-87c1-1cd9e2296f71@itdev.co.uk>
References: <1462381638-7818-1-git-send-email-nick.dyer@itdev.co.uk>
 <1462381638-7818-3-git-send-email-nick.dyer@itdev.co.uk>
 <57483FD1.9080704@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zencphosting06.zen.co.uk ([82.71.204.9]:54993 "EHLO
	zencphosting06.zen.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbcE0Mwq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 May 2016 08:52:46 -0400
In-Reply-To: <57483FD1.9080704@xs4all.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Benson Leung <bleung@chromium.org>, Alan Bowens <Alan.Bowens@atmel.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Chris Healy <cphealy@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Andrew Duggan <aduggan@synaptics.com>, James Chen <james.chen@emc.com.tw>, Dudley Du <dudl@cypress.com>, Andrew de los Reyes <adlr@chromium.org>, sheckylin@chromium.org, Peter Hutterer <peter.hutterer@who-t.net>, Florian Echtler <floe@butterbrot.org>, mchehab@osg.samsung.com

On 27/05/2016 13:38, Hans Verkuil wrote:
> On 05/04/2016 07:07 PM, Nick Dyer wrote:
>> +    <refname><constant>V4L2_PIX_FMT_YS16</constant></refname>
>> +    <refpurpose>Grey-scale image</refpurpose>
>> +  </refnamediv>
>> +  <refsect1>
>> +    <title>Description</title>
>> +
>> +    <para>This is a signed grey-scale image with a depth of 16 bits per
>> +pixel. The most significant byte is stored at higher memory addresses
>> +(little-endian).</para>
> 
> I'm not sure this should be described in terms of grey-scale, since negative
> values make no sense for that. How are these values supposed to be interpreted
> if you want to display them? -32768 == black and 32767 is white?

We have written a utility to display this data and it is able to display
the values mapped to grayscale or color:
https://github.com/ndyer/heatmap/blob/master/src/display.c#L44

An example of the output is here:
https://www.youtube.com/watch?v=Uj4T6fUCySw

The data is intrinsically signed because that's how the low level touch
controller treats it. I'm happy to change it to "Signed image" if you think
that would be better.
