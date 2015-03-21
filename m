From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 2/2] HID: HID Sensor: Update document for custom sensor
Date: Sat, 21 Mar 2015 11:22:07 +0000
Message-ID: <550D545F.1060408@kernel.org>
References: <1426888728-9344-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1426888728-9344-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426888728-9344-3-git-send-email-srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, jkosina-AlSwsSmVLrQ@public.gmane.org
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 20/03/15 21:58, Srinivas Pandruvada wrote:
> Added custom sensor documentation
>=20
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563A2t4k+OOtxA@public.gmane.org=
om>
Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
(now with the name attribute ;)
> ---
>  Documentation/hid/hid-sensor.txt | 84 ++++++++++++++++++++++++++++++=
++++++++++
>  1 file changed, 84 insertions(+)
>=20
> diff --git a/Documentation/hid/hid-sensor.txt b/Documentation/hid/hid=
-sensor.txt
> index 948b098..073052f 100644
> --- a/Documentation/hid/hid-sensor.txt
> +++ b/Documentation/hid/hid-sensor.txt
> @@ -138,3 +138,87 @@ accelerometer wants to poll X axis value, then i=
t can call this function with
>  the usage id of X axis. HID sensors can provide events, so this is n=
ot necessary
>  to poll for any field. If there is some new sample, the core driver =
will call
>  registered callback function to process the sample.
> +
> +
> +----------
> +
> +HID Custom and generic Sensors
> +
> +HID Sensor specification defines two special sensor usage types. Sin=
ce they
> +don't represent a standard sensor, it is not possible to define usin=
g Linux IIO
> +type interfaces.
> +The purpose of these sensors is to extend the functionality or provi=
de a
> +way to obfuscate the data being communicated by a sensor. Without kn=
owing the
> +mapping between the data and its encapsulated form, it is difficult =
for
> +an application/driver to determine what data is being communicated b=
y the sensor.
> +This allows some differentiating use cases, where vendor can provide=
 applications.
> +Some common use cases are debug other sensors or to provide some eve=
nts like
> +keyboard attached/detached or lid open/close.
> +
> +To allow application to utilize these sensors, here they are exporte=
d uses sysfs
> +attribute groups, attributes and misc device interface.
> +
> +An example of this representation on sysfs:
> +/sys/devices/pci0000:00/INT33C2:00/i2c-0/i2c-INT33D1:00/0018:8086:09=
=46A.0001/HID-SENSOR-2000e1.6.auto$ tree -R
> +.
> +=E2=94=9C=E2=94=80=E2=94=80 enable_sensor
> +=E2=94=9C=E2=94=80=E2=94=80 feature-0-200316
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 feature-0-200316-maximum
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 feature-0-200316-minimum
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 feature-0-200316-name
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 feature-0-200316-size
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 feature-0-200316-unit-expo
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 feature-0-200316-units
> +=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 feature-0-200316-value
> +=E2=94=9C=E2=94=80=E2=94=80 feature-1-200201
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 feature-1-200201-maximum
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 feature-1-200201-minimum
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 feature-1-200201-name
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 feature-1-200201-size
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 feature-1-200201-unit-expo
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 feature-1-200201-units
> +=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 feature-1-200201-value
> +=E2=94=9C=E2=94=80=E2=94=80 input-0-200201
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 input-0-200201-maximum
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 input-0-200201-minimum
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 input-0-200201-name
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 input-0-200201-size
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 input-0-200201-unit-expo
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 input-0-200201-units
> +=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 input-0-200201-value
> +=E2=94=9C=E2=94=80=E2=94=80 input-1-200202
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 input-1-200202-maximum
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 input-1-200202-minimum
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 input-1-200202-name
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 input-1-200202-size
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 input-1-200202-unit-expo
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 input-1-200202-units
> +=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 input-1-200202-value
> +
> +Here there is a custom sensors with four fields, two feature and two=
 inputs.
> +Each field is represented by a set of attributes. All fields except =
the "value"
> +are read only. The value field is a RW field.
> +Example
> +/sys/bus/platform/devices/HID-SENSOR-2000e1.6.auto/feature-0-200316$=
 grep -r . *
> +feature-0-200316-maximum:6
> +feature-0-200316-minimum:0
> +feature-0-200316-name:property-reporting-state
> +feature-0-200316-size:1
> +feature-0-200316-unit-expo:0
> +feature-0-200316-units:25
> +feature-0-200316-value:1
> +
> +How to enable such sensor?
> +By default sensor can be power gated. To enable sysfs attribute "ena=
ble" can be
> +used.
> +$ echo 1 > enable_sensor
> +
> +Once enabled and powered on, sensor can report value using HID repor=
ts.
> +These reports are pushed using misc device interface in a FIFO order=
=2E
> +/dev$ tree | grep HID-SENSOR-2000e1.6.auto
> +=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 10:53 -> ../HID-SENSOR-2000e=
1.6.auto
> +=E2=94=9C=E2=94=80=E2=94=80 HID-SENSOR-2000e1.6.auto
> +
> +Each reports can be of variable length preceded by a header. This he=
ader
> +consist of a 32 bit usage id, 64 bit time stamp and 32 bit length fi=
eld of raw
> +data.
>=20
