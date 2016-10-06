From: "Simon Wood" <simon@mungewell.org>
Subject: Re: [PATCH 1/2] HID: sony: Adjust value range for motion sensors
Date: Thu, 6 Oct 2016 09:16:09 -0600
Message-ID: <dfff4e665925857655866517466a7000.squirrel@mungewell.org>
References: <6BB4B6CF-1DB7-4F90-8D7F-558407E57203@gmail.com>
    <AB243ECF-9931-4C76-9E54-A9D15E06C3F4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host18.canaca.com ([66.49.204.205]:48764 "EHLO
        host18.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755503AbcJFPQK (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 6 Oct 2016 11:16:10 -0400
In-Reply-To: <AB243ECF-9931-4C76-9E54-A9D15E06C3F4@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roderick Colenbrander <roderick@gaikai.com>
Cc: linux-input@vger.kernel.org, Frank Praznik <frank.praznik@gmail.com>

On Thu, October 6, 2016 8:27 am, Frank Praznik wrote:
>

>> The motion sensor values are 16-bit, so make the value range match.
>> It is hard to reach the upper values, but they can be reached. At
>> least the current accelerometer value of 8192 is very easy to pass.
>>
>>
>
> Are the gyro values intended to be scaled in any way?  The current
> min/max values were based on the observed maximum extents of the
> controller at rest.  With this change the controller at rest will never
> appear to be turned more than 22.5 degrees in any direction to an
> application which assumes that the logical extents represent the device
> at 90 degrees.

Don't forget that the _gyro_ values are a 'rate of turn' ie. 'degrees per
second'.

Since we're asking questions, I'd love to know more about the time
stamping of the accel/gyro data as this could improve AHRS/Kalman
performance significantly.

In the Move we get two sets of accel/gyro data, what's that about?
Simon

