From: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 2/2] HID: HID Sensor: Update document for custom sensor
Date: Mon, 16 Mar 2015 16:09:03 -0700
Message-ID: <1426547343-27747-3-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1426547343-27747-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426547343-27747-1-git-send-email-srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jkosina-AlSwsSmVLrQ@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Added custom sensor documentation

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org=
>
---
 Documentation/hid/hid-sensor.txt | 79 ++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 79 insertions(+)

diff --git a/Documentation/hid/hid-sensor.txt b/Documentation/hid/hid-s=
ensor.txt
index 948b098..1a63538 100644
--- a/Documentation/hid/hid-sensor.txt
+++ b/Documentation/hid/hid-sensor.txt
@@ -138,3 +138,82 @@ accelerometer wants to poll X axis value, then it =
can call this function with
 the usage id of X axis. HID sensors can provide events, so this is not=
 necessary
 to poll for any field. If there is some new sample, the core driver wi=
ll call
 registered callback function to process the sample.
+
+
+----------
+
+HID Custom and generic Sensors
+
+HID Sensor specification defines two special sensor usage types. Since=
 they
+don't represent a standard sensor, it is not possible to define using =
Linux IIO
+type interfaces.
+The purpose of these sensors is to extend the functionality or provide=
 a
+way to obfuscate the data being communicated by a sensor. Without know=
ing the
+mapping between the data and its encapsulated form, it is difficult fo=
r
+an application/driver to determine what data is being communicated by =
the sensor.
+This allows some differentiating use cases, where vendor can provide a=
pplications.
+Some common use cases are debug other sensors or to provide some event=
s like
+keyboard attached/detached or lid open/close.
+
+To allow application to utilize these sensors, here they are exported =
uses sysfs
+attribute groups, attributes and misc device interface.
+
+An example of this representation on sysfs:
+/sys/devices/pci0000:00/INT33C2:00/i2c-0/i2c-INT33D1:00/0018:8086:09FA=
=2E0001/HID-SENSOR-2000e1.6.auto$ tree -R
+.
+=E2=94=9C=E2=94=80=E2=94=80 enable_sensor
+=E2=94=9C=E2=94=80=E2=94=80 feature-0-200316
+=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 feature-0-200316-max=
imum
+=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 feature-0-200316-min=
imum
+=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 feature-0-200316-siz=
e
+=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 feature-0-200316-uni=
t-expo
+=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 feature-0-200316-uni=
ts
+=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 feature-0-200316-val=
ue
+=E2=94=9C=E2=94=80=E2=94=80 feature-1-200201
+=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 feature-1-200201-max=
imum
+=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 feature-1-200201-min=
imum
+=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 feature-1-200201-siz=
e
+=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 feature-1-200201-uni=
t-expo
+=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 feature-1-200201-uni=
ts
+=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 feature-1-200201-val=
ue
+=E2=94=9C=E2=94=80=E2=94=80 input-0-200201
+=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 input-0-200201-maxim=
um
+=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 input-0-200201-minim=
um
+=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 input-0-200201-size
+=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 input-0-200201-unit-=
expo
+=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 input-0-200201-units
+=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 input-0-200201-value
+=E2=94=9C=E2=94=80=E2=94=80 input-1-200202
+=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 input-1-200202-maxim=
um
+=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 input-1-200202-minim=
um
+=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 input-1-200202-size
+=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 input-1-200202-unit-=
expo
+=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 input-1-200202-units
+=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 input-1-200202-value
+
+Here there is a custom sensors with four fields, two feature and two i=
nputs.
+Each field is represented by a set of attributes. All fields except th=
e "value"
+are read only. The value field is a RW field.
+Example
+/sys/bus/platform/devices/HID-SENSOR-2000e1.6.auto/feature-0-200316$ g=
rep -r . *
+feature-0-200316-maximum:6
+feature-0-200316-minimum:0
+feature-0-200316-size:1
+feature-0-200316-unit-expo:0
+feature-0-200316-units:25
+feature-0-200316-value:1
+
+How to enable such sensor?
+By default sensor can be power gated. To enable sysfs attribute "enabl=
e" can be
+used.
+$ echo 1 > enable_sensor
+
+Once enabled and powered on, sensor can report value using HID reports=
=2E
+These reports are pushed using misc device interface in a FIFO order.
+/dev$ tree | grep HID-SENSOR-2000e1.6.auto
+=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 10:53 -> ../HID-SENS=
OR-2000e1.6.auto
+=E2=94=9C=E2=94=80=E2=94=80 HID-SENSOR-2000e1.6.auto
+
+Each reports can be of variable length preceded by a header. This head=
er
+consist of a 32 bit usage id, 64 bit time stamp and 32 bit length fiel=
d of raw
+data.
--=20
2.1.0
