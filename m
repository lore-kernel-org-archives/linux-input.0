From: Clinton Sprain <clintonsprain@gmail.com>
Subject: Re: [PATCH v2 2/3] input: appletouch: use better cursor movement
 smoothing algorithm
Date: Tue, 11 Feb 2014 01:19:28 -0600
Message-ID: <52F9CF00.8080202@gmail.com>
References: <52D9DE7A.7040509@gmail.com> <52F42AEE.3040505@gmail.com> <52F42C32.8080408@gmail.com> <52F7714D.7040409@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:43865 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbaBKHTb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Feb 2014 02:19:31 -0500
Received: by mail-ie0-f182.google.com with SMTP id lx4so4313642iec.41
        for <linux-input@vger.kernel.org>; Mon, 10 Feb 2014 23:19:31 -0800 (PST)
In-Reply-To: <52F7714D.7040409@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>, linux-input <linux-input@vger.kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi Henrik,

On 02/09/2014 06:15 AM, Henrik Rydberg wrote:
> Hi Clinton,
> 
>> Use smoothed version of sensor array data to calculate movement and add weight
> to prior values when calculating average. This gives more granular and more
> predictable movement.
>>
>> Signed-off-by: Clinton Sprain <clintonsprain@gmail.com>
>> ---
>>  drivers/input/mouse/appletouch.c |   60 ++++++++++++++++++++++++++------------
>>  1 file changed, 42 insertions(+), 18 deletions(-)
> 
> I like this patch, but there are some technical glitches, comments below.
> 
>> diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
>> index d48181b..edbdd95 100644
>> --- a/drivers/input/mouse/appletouch.c
>> +++ b/drivers/input/mouse/appletouch.c
>> @@ -338,21 +338,51 @@ static void atp_reinit(struct work_struct *work)
>>  static int atp_calculate_abs(int *xy_sensors, int nb_sensors, int fact,
>>  			     int *z, int *fingers)
>>  {
>> -	int i;
>> +	int i, k;
>> +	int smooth[nb_sensors + 2];
>> +	int smooth_tmp[nb_sensors + 2];
>> +
>>  	/* values to calculate mean */
>>  	int pcum = 0, psum = 0;
>>  	int is_increasing = 0;
>>  
>>  	*fingers = 0;
>>  
>> +	/*
>> +	 * Use a smoothed version of sensor data for movement calculations, to
>> +	 * combat noise without needing to toss out values based on a threshold.
>> +	 * This improves tracking. Finger count is calculated separately based
>> +	 * on raw data.
>> +	 */
>> +
>> +	for (i = 0; i < nb_sensors; i++) {           /* Scale up to minimize */
>> +		smooth[i] = xy_sensors[i] << 12;     /* rounding/truncation. */
>> +	}
>> +
>> +	/* Mitigate some of the data loss from smoothing on the edge sensors. */
>> +	smooth[-1] = smooth[0] >> 2;
>> +	smooth[nb_sensors] = smooth[nb_sensors - 1] >> 2;
> 
> Out of bounds array... also, the boundary condition seems odd. If you want to
> extrapolate the edge velocity, and assuming smooth[0] is the first sensor, you
> would get something like (N = nb_sensors)
> 
> 	smooth_tmp[0] = 2 * smooth[1] - smooth[2];
> 	smooth_tmp[N-1] = 2 * smooth[N-2] - smooth[N-3];
> 

This produces a big velocity increase when the finger crosses over from sensor 0 to sensor 1 or vice versa.

We might get by with something relatively simple:

smooth_tmp[0] = (3 * smooth[0] + smooth[1]) >> 2;

...and the same thing on the other edge. This produces predictable behavior while keeping values from bleeding off the board so to speak. (Less important now than if someone down the line ever decides to increase the number of passes.)

>> +	for (k = 0; k < 4; k++) {
>> +		for (i = 0; i < nb_sensors; i++) {   /* Blend with neighbors. */
> 
> And here would be for (i = 1; i < nb_sensors - 1; i++)
> 
>> +			smooth_tmp[i] = (smooth[i - 1] + smooth[i] * 2 + smooth[i + 1]) >> 2;
>> +		}
>> +
>> +		for (i = 0; i < nb_sensors; i++) {
>> +			smooth[i] = smooth_tmp[i];
>> +			if (k == 3)     /* Last go-round, so scale back down. */
>> +				smooth[i] = smooth[i] >> 12;
> 
> The scale-up is done separately, so why not make the scale-down separately too?
> 
>> +		}
>> +
>> +		smooth[-1] = smooth[0] >> 2;
>> +		smooth[nb_sensors] = smooth[nb_sensors - 1] >> 2;
> 
> And these would be dropped.
> 
>> +	}
>> +
>>  	for (i = 0; i < nb_sensors; i++) {
>>  		if (xy_sensors[i] < threshold) {
>>  			if (is_increasing)
>>  				is_increasing = 0;
>>  
>> -			continue;
>> -		}
>> -
>>  		/*
>>  		 * Makes the finger detection more versatile.  For example,
>>  		 * two fingers with no gap will be detected.  Also, my
>> @@ -367,7 +397,8 @@ static int atp_calculate_abs(int *xy_sensors, int nb_sensors, int fact,
>>  		 *
>>  		 * - Jason Parekh <jasonparekh@gmail.com>
>>  		 */
>> -		if (i < 1 ||
>> +
>> +		} else if (i < 1 ||
>>  		    (!is_increasing && xy_sensors[i - 1] < xy_sensors[i])) {
>>  			(*fingers)++;
>>  			is_increasing = 1;
>> @@ -375,15 +406,8 @@ static int atp_calculate_abs(int *xy_sensors, int nb_sensors, int fact,
>>  			is_increasing = 0;
>>  		}
>>  
>> -		/*
>> -		 * Subtracts threshold so a high sensor that just passes the
>> -		 * threshold won't skew the calculated absolute coordinate.
>> -		 * Fixes an issue where slowly moving the mouse would
>> -		 * occasionally jump a number of pixels (slowly moving the
>> -		 * finger makes this issue most apparent.)
>> -		 */
>> -		pcum += (xy_sensors[i] - threshold) * i;
>> -		psum += (xy_sensors[i] - threshold);
>> +		pcum += (smooth[i]) * i;
>> +		psum += (smooth[i]);
> 
> Great, this makes so much more sense.
> 
>>  	}
>>  
>>  	if (psum > 0) {
>> @@ -565,8 +589,8 @@ static void atp_complete_geyser_1_2(struct urb *urb)
>>  
>>  	if (x && y) {
>>  		if (dev->x_old != -1) {
>> -			x = (dev->x_old * 3 + x) >> 2;
>> -			y = (dev->y_old * 3 + y) >> 2;
>> +			x = (dev->x_old * 7 + x) >> 3;
>> +			y = (dev->y_old * 7 + y) >> 3;
>>  			dev->x_old = x;
>>  			dev->y_old = y;
>>  
>> @@ -677,8 +701,8 @@ static void atp_complete_geyser_3_4(struct urb *urb)
>>  
>>  	if (x && y) {
>>  		if (dev->x_old != -1) {
>> -			x = (dev->x_old * 3 + x) >> 2;
>> -			y = (dev->y_old * 3 + y) >> 2;
>> +			x = (dev->x_old * 7 + x) >> 3;
>> +			y = (dev->y_old * 7 + y) >> 3;
>>  			dev->x_old = x;
>>  			dev->y_old = y;
> 
> Would you say that the cursor slow-down here is noticeable, or are there enough
> samples per second that it does not matter?

Noticeable but not major. It's still possible to move the cursor across the screen in one movement with typical defaults, and the gain in smoothness is pretty big, so it seems like a reasonable trade-off. (The 'base' speed is also still quicker than the native OS driver, FWIW.)

> 
> Thanks,
> Henrik
> 

Thanks,
Clinton
