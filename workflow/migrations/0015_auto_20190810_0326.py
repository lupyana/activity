# Generated by Django 2.2.3 on 2019-08-10 10:26

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('workflow', '0014_stakeholder_organization'),
    ]

    operations = [
        migrations.AddField(
            model_name='siteprofile',
            name='organizations',
            field=models.ManyToManyField(blank=True, related_name='organizations', to='workflow.Organization'),
        ),
        migrations.AlterField(
            model_name='activityuser',
            name='organization',
            field=models.ForeignKey(blank=True, default=1, null=True, on_delete=django.db.models.deletion.SET_NULL, to='workflow.Organization', verbose_name='Active Organization'),
        ),
        migrations.AlterField(
            model_name='program',
            name='cost_center',
            field=models.CharField(blank=True, max_length=255, null=True, verbose_name='Cost Center'),
        ),
    ]