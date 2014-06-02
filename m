From: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 1/3] IIO: Add iio magn_north ABI documentation
Date: Mon, 02 Jun 2014 08:54:57 -0700
Message-ID: <538C9E51.2000806@linux.intel.com>
References: <1401311175-12784-1-git-send-email-reyad.attiyat@gmail.com> <1401311175-12784-2-git-send-email-reyad.attiyat@gmail.com> <53876477.7000503@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53876477.7000503-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Reyad Attiyat <reyad.attiyat-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 05/29/2014 09:46 AM, Jonathan Cameron wrote:
> On 28/05/14 22:06, Reyad Attiyat wrote:
>> Update documentation for HID compass true/magnetic north sensor.
>>
>> Signed-off-by: Reyad Attiyat <reyad.attiyat-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>   Documentation/ABI/testing/sysfs-bus-iio | 76 
>> +++++++++++++++++++++++++++++++++
>>   1 file changed, 76 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio 
>> b/Documentation/ABI/testing/sysfs-bus-iio
>> index 6e02c50..0341b2f 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>> @@ -165,6 +165,10 @@ Description:
>>   What:        /sys/bus/iio/devices/iio:deviceX/in_magn_x_raw
>>   What:        /sys/bus/iio/devices/iio:deviceX/in_magn_y_raw
>>   What:        /sys/bus/iio/devices/iio:deviceX/in_magn_z_raw
> Hmm. The question to my mind is whether people would expect a simple 
> north to give
> them which direction north is?
> Also is it actually relevant whether they find north from a 
> magnetometer or some other method?
> I wonder if we want to make these some sort of north referenced rotation?
> in_rot_from_true_north_raw
> in_rot_from_magnetic_north_raw
>
> Technically it is possible to get some direction information from some 
> GPS receivers or to
> to maintain a knowledge of its location with good gyroscopes.
>
> Ultimately userspace doesn't care about it.  When we were using the 
> axial magnetic functions we
> were measuring the field magnitude in that direction. As I understand 
> it here it is just an angle?
Yes, they are angles. Default units are degrees, which we should convert 
to radians as a standard unit for IIO.
Thanks,
Srinivas
>
> J
>> +What: /sys/bus/iio/devices/iio:deviceX/in_magn_north_raw
>> +What: /sys/bus/iio/devices/iio:deviceX/in_magn_north_true_raw
>> +What: /sys/bus/iio/devices/iio:deviceX/in_magn_north_tilt_comp_raw
>> +What: /sys/bus/iio/devices/iio:deviceX/in_magn_north_true_tilt_comp_raw
>>   KernelVersion:    2.6.35
>>   Contact:    linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>   Description:
>> @@ -249,6 +253,10 @@ What: 
>> /sys/bus/iio/devices/iio:deviceX/in_magn_scale
>>   What:        /sys/bus/iio/devices/iio:deviceX/in_magn_x_scale
>>   What:        /sys/bus/iio/devices/iio:deviceX/in_magn_y_scale
>>   What:        /sys/bus/iio/devices/iio:deviceX/in_magn_z_scale
>> +What: /sys/bus/iio/devices/iio:deviceX/in_magn_north_scale
>> +What: /sys/bus/iio/devices/iio:deviceX/in_magn_north_true_scale
>> +What: /sys/bus/iio/devices/iio:deviceX/in_magn_north_tilt_comp_scale
>> +What: 
>> /sys/bus/iio/devices/iio:deviceX/in_magn_north_true_tilt_comp_scale
>>   What: /sys/bus/iio/devices/iio:deviceX/in_pressureY_scale
>>   What: /sys/bus/iio/devices/iio:deviceX/in_pressure_scale
>>   KernelVersion:    2.6.35
>> @@ -436,6 +444,14 @@ What: 
>> /sys/.../iio:deviceX/events/in_magn_y_thresh_rising_en
>>   What: /sys/.../iio:deviceX/events/in_magn_y_thresh_falling_en
>>   What: /sys/.../iio:deviceX/events/in_magn_z_thresh_rising_en
>>   What: /sys/.../iio:deviceX/events/in_magn_z_thresh_falling_en
>> +What: /sys/.../iio:deviceX/events/in_magn_north_thresh_rising_en
>> +What: /sys/.../iio:deviceX/events/in_magn_north_thresh_falling_en
>> +What: /sys/.../iio:deviceX/events/in_magn_north_true_thresh_rising_en
>> +What: /sys/.../iio:deviceX/events/in_magn_north_true_thresh_falling_en
>> +What: 
>> /sys/.../iio:deviceX/events/in_magn_north_tilt_comp_thresh_rising_en
>> +What: 
>> /sys/.../iio:deviceX/events/in_magn_north_tilt_comp_thresh_falling_en
>> +What: 
>> /sys/.../iio:deviceX/events/in_magn_north_true_tilt_comp_thresh_rising_en
>> +What: 
>> /sys/.../iio:deviceX/events/in_magn_north_true_tilt_comp_thresh_falling_en
>>   What: /sys/.../iio:deviceX/events/in_voltageY_supply_thresh_rising_en
>>   What: /sys/.../iio:deviceX/events/in_voltageY_supply_thresh_falling_en
>>   What: /sys/.../iio:deviceX/events/in_voltageY_thresh_rising_en
>> @@ -481,6 +497,14 @@ What: 
>> /sys/.../iio:deviceX/events/in_magn_y_roc_rising_en
>>   What: /sys/.../iio:deviceX/events/in_magn_y_roc_falling_en
>>   What: /sys/.../iio:deviceX/events/in_magn_z_roc_rising_en
>>   What: /sys/.../iio:deviceX/events/in_magn_z_roc_falling_en
>> +What: /sys/.../iio:deviceX/events/in_magn_north_roc_rising_en
>> +What: /sys/.../iio:deviceX/events/in_magn_north_roc_falling_en
>> +What: /sys/.../iio:deviceX/events/in_magn_north_true_roc_rising_en
>> +What: /sys/.../iio:deviceX/events/in_magn_north_true_roc_falling_en
>> +What: /sys/.../iio:deviceX/events/in_magn_north_tilt_comp_roc_rising_en
>> +What: 
>> /sys/.../iio:deviceX/events/in_magn_north_tilt_comp_roc_falling_en
>> +What: 
>> /sys/.../iio:deviceX/events/in_magn_north_true_tilt_comp_roc_rising_en
>> +What: 
>> /sys/.../iio:deviceX/events/in_magn_north_true_tilt_comp_roc_falling_en
>>   What: /sys/.../iio:deviceX/events/in_voltageY_supply_roc_rising_en
>>   What: /sys/.../iio:deviceX/events/in_voltageY_supply_roc_falling_en
>>   What: /sys/.../iio:deviceX/events/in_voltageY_roc_rising_en
>> @@ -527,6 +551,14 @@ What: 
>> /sys/.../events/in_magn_y_raw_thresh_rising_value
>>   What: /sys/.../events/in_magn_y_raw_thresh_falling_value
>>   What:        /sys/.../events/in_magn_z_raw_thresh_rising_value
>>   What: /sys/.../events/in_magn_z_raw_thresh_falling_value
>> +What: /sys/.../events/in_magn_north_raw_thresh_rising_value
>> +What: /sys/.../events/in_magn_north_raw_thresh_falling_value
>> +What: /sys/.../events/in_magn_north_true_raw_thresh_rising_value
>> +What: /sys/.../events/in_magn_north_true_raw_thresh_falling_value
>> +What: /sys/.../events/in_magn_north_tilt_comp_raw_thresh_rising_value
>> +What: /sys/.../events/in_magn_north_tilt_comp_raw_thresh_falling_value
>> +What: 
>> /sys/.../events/in_magn_north_true_tilt_comp_raw_thresh_rising_value
>> +What: 
>> /sys/.../events/in_magn_north_true_tilt_comp_raw_thresh_falling_value
>>   What: /sys/.../events/in_voltageY_supply_raw_thresh_rising_value
>>   What: /sys/.../events/in_voltageY_supply_raw_thresh_falling_value
>>   What: /sys/.../events/in_voltageY_raw_thresh_rising_value
>> @@ -577,6 +609,18 @@ What: 
>> /sys/.../events/in_magn_y_thresh_either_hysteresis
>>   What: /sys/.../events/in_magn_z_thresh_rising_hysteresis
>>   What: /sys/.../events/in_magn_z_thresh_falling_hysteresis
>>   What: /sys/.../events/in_magn_z_thresh_either_hysteresis
>> +What: /sys/.../events/in_magn_north_thresh_rising_hysteresis
>> +What: /sys/.../events/in_magn_north_thresh_falling_hysteresis
>> +What: /sys/.../events/in_magn_north_thresh_either_hysteresis
>> +What: /sys/.../events/in_magn_north_true_thresh_rising_hysteresis
>> +What: /sys/.../events/in_magn_north_true_thresh_falling_hysteresis
>> +What: /sys/.../events/in_magn_north_true_thresh_either_hysteresis
>> +What: /sys/.../events/in_magn_north_tilt_comp_thresh_rising_hysteresis
>> +What: /sys/.../events/in_magn_north_tilt_comp_thresh_falling_hysteresis
>> +What: /sys/.../events/in_magn_north_tilt_comp_thresh_either_hysteresis
>> +What: 
>> /sys/.../events/in_magn_north_true_tilt_comp_thresh_rising_hysteresis
>> +What: 
>> /sys/.../events/in_magn_north_true_tilt_comp_thresh_falling_hysteresis
>> +What: 
>> /sys/.../events/in_magn_north_true_tilt_comp_thresh_either_hysteresis
>>   What: /sys/.../events/in_voltageY_thresh_rising_hysteresis
>>   What: /sys/.../events/in_voltageY_thresh_falling_hysteresis
>>   What: /sys/.../events/in_voltageY_thresh_either_hysteresis
>> @@ -624,6 +668,14 @@ What: 
>> /sys/.../events/in_magn_y_raw_roc_rising_value
>>   What:        /sys/.../events/in_magn_y_raw_roc_falling_value
>>   What:        /sys/.../events/in_magn_z_raw_roc_rising_value
>>   What:        /sys/.../events/in_magn_z_raw_roc_falling_value
>> +What:        /sys/.../events/in_magn_north_raw_roc_rising_value
>> +What: /sys/.../events/in_magn_north_raw_roc_falling_value
>> +What: /sys/.../events/in_magn_north_true_raw_roc_rising_value
>> +What: /sys/.../events/in_magn_north_true_raw_roc_falling_value
>> +What: /sys/.../events/in_magn_north_tilt_comp_raw_roc_rising_value
>> +What: /sys/.../events/in_magn_north_tilt_comp_raw_roc_falling_value
>> +What: /sys/.../events/in_magn_north_true_tilt_comp_raw_roc_rising_value
>> +What: 
>> /sys/.../events/in_magn_north_true_tilt_comp_raw_roc_falling_value
>>   What: /sys/.../events/in_voltageY_supply_raw_roc_rising_value
>>   What: /sys/.../events/in_voltageY_supply_raw_roc_falling_value
>>   What:        /sys/.../events/in_voltageY_raw_roc_rising_value
>> @@ -679,6 +731,22 @@ What: 
>> /sys/.../events/in_magn_z_thresh_rising_period
>>   What:        /sys/.../events/in_magn_z_thresh_falling_period
>>   What:        /sys/.../events/in_magn_z_roc_rising_period
>>   What:        /sys/.../events/in_magn_z_roc_falling_period
>> +What:        /sys/.../events/in_magn_north_thresh_rising_period
>> +What: /sys/.../events/in_magn_north_thresh_falling_period
>> +What:        /sys/.../events/in_magn_north_roc_rising_period
>> +What:        /sys/.../events/in_magn_north_roc_falling_period
>> +What: /sys/.../events/in_magn_north_true_thresh_rising_period
>> +What: /sys/.../events/in_magn_north_true_thresh_falling_period
>> +What: /sys/.../events/in_magn_north_true_roc_rising_period
>> +What: /sys/.../events/in_magn_north_true_roc_falling_period
>> +What: /sys/.../events/in_magn_north_tilt_comp_thresh_rising_period
>> +What: /sys/.../events/in_magn_north_tilt_comp_thresh_falling_period
>> +What: /sys/.../events/in_magn_north_tilt_comp_roc_rising_period
>> +What: /sys/.../events/in_magn_north_tilt_comp_roc_falling_period
>> +What: /sys/.../events/in_magn_north_true_tilt_comp_thresh_rising_period
>> +What: 
>> /sys/.../events/in_magn_north_true_tilt_comp_thresh_falling_period
>> +What: /sys/.../events/in_magn_north_true_tilt_comp_roc_rising_period
>> +What: /sys/.../events/in_magn_north_true_tilt_comp_roc_falling_period
>>   What: /sys/.../events/in_voltageY_supply_thresh_rising_period
>>   What: /sys/.../events/in_voltageY_supply_thresh_falling_period
>>   What: /sys/.../events/in_voltageY_supply_roc_rising_period
>> @@ -776,6 +844,10 @@ What: 
>> /sys/.../iio:deviceX/scan_elements/in_anglvel_z_en
>>   What:        /sys/.../iio:deviceX/scan_elements/in_magn_x_en
>>   What:        /sys/.../iio:deviceX/scan_elements/in_magn_y_en
>>   What:        /sys/.../iio:deviceX/scan_elements/in_magn_z_en
>> +What: /sys/.../iio:deviceX/scan_elements/in_magn_north_en
>> +What: /sys/.../iio:deviceX/scan_elements/in_magn_north_true_en
>> +What: /sys/.../iio:deviceX/scan_elements/in_magn_north_tilt_comp_en
>> +What: 
>> /sys/.../iio:deviceX/scan_elements/in_magn_north_true_tilt_comp_en
>>   What: /sys/.../iio:deviceX/scan_elements/in_timestamp_en
>>   What: /sys/.../iio:deviceX/scan_elements/in_voltageY_supply_en
>>   What:        /sys/.../iio:deviceX/scan_elements/in_voltageY_en
>> @@ -840,6 +912,10 @@ What: 
>> /sys/.../iio:deviceX/scan_elements/in_anglvel_z_index
>>   What: /sys/.../iio:deviceX/scan_elements/in_magn_x_index
>>   What: /sys/.../iio:deviceX/scan_elements/in_magn_y_index
>>   What: /sys/.../iio:deviceX/scan_elements/in_magn_z_index
>> +What: /sys/.../iio:deviceX/scan_elements/in_magn_north_index
>> +What: /sys/.../iio:deviceX/scan_elements/in_magn_north_true_index
>> +What: /sys/.../iio:deviceX/scan_elements/in_magn_north_tilt_comp_index
>> +What: 
>> /sys/.../iio:deviceX/scan_elements/in_magn_north_true_tilt_comp_index
>>   What: /sys/.../iio:deviceX/scan_elements/in_incli_x_index
>>   What: /sys/.../iio:deviceX/scan_elements/in_incli_y_index
>>   What: /sys/.../iio:deviceX/scan_elements/in_timestamp_index
>>
>
>
